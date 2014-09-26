#!/usr/bin/env bash

. ../commit_velocity.sh

for unit in "min" "hr" "day" "week" "month"; do
  my_velocity=$(commit_velocity $unit relative)
  my_velocity_value=$(echo $my_velocity | awk '{print $1}')
  my_velocity_unit=$(echo $my_velocity | awk '{print $2}')

  if [[ " commits/$unit" = $my_velocity_unit ]]; then
    echo "Test Failure, bad units: $my_velocity"
    exit 1
  fi

  if [[ $unit = "min" ]]; then
    if [[ $my_velocity_value -ne 0 ]]; then 
      echo Test Failure, bad value: $my_velocity
      exit 1
    fi
  else
    if [[ $my_velocity_value -lt 1 ]]; then
      echo Test Failure, bad value: $my_velocity
      exit 1
    fi
  fi

done

echo "Tests Passed \o/"
