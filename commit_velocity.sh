function commit_velocity()
{
  if [[ ! "min hr day week month" =~ (^| )$1($| ) || ! "relative absolute" =~ (^| )$2($| ) ]] 
  then
    echo "Calculate the commit velocity of any mercurial or git repository. Relative" 
    echo "velocity is measured from the last commit, absolute from date +%s."
    echo ""
    echo "USAGE: commit_velocity <min|hr|day|week|month> <relative|absolute> [ hg|git log ...]"
    return 0
  fi

  # specially formatted log commands are used to obtain list of timestamps 
  # users may optionally pass in extra parameters top the <hg|git> log function
  if [ "$(git status 2> /dev/null)" ]; then
    logs=$(git log --format="%at" ${@:3})

  elif [ "$(hg summary 2> /dev/null)" ]; then
    logs=$(hg log --template "{date(date, '%s')}\n" ${@:3})
  else
    echo "I can only calculate the velocity of git and hg repositories."
    return 1
  fi
 
  today=$(date +%s)

  count=0
  for log in $logs; do
    count=$((count+1))
    last_log=$log
    if [[ "$count" -eq 1 && "$2" = "relative" ]]; then today=$last_log; fi
  done

  if [ "$count" -gt 0 ]; then
    result=0
    time_delta_sec=$((today-last_log))
    
    if [ "$1" = "min" ]; then
      result=$((count*60/time_delta_sec))
    elif [ "$1" = "hr" ]; then
      result=$((count*3600/time_delta_sec))
    elif [ "$1" = "day" ]; then
      result=$((count*3600*24/time_delta_sec))
    elif [ "$1" = "week" ]; then
      result=$((count*3600*24*7/time_delta_sec))
    elif [ "$1" = "month" ]; then
      result=$((count*3600*24*7*4/time_delta_sec))
    fi
    
    echo $result commits/$1
  
  else
    echo "Not enough commits to calculate velocity."
  fi
}
