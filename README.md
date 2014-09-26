commit_velocity
===============

<img src="commit_velocity.png"/>

####About

This is a handy bash function which will calculate the velocity of any mercurial
or git repository. Velocity may be relative or absolute, meaning, calculated
against the current timestamp or against the most recent commit.

####Install

Since this is a bash function you should source the file:

manually: ``source commit_velocity.sh``

bash_profile: ``echo ". source `pwd`/commit_velocity.sh" >> ~/.bash_profile``

####Usage

  ``commit_velocity <min|hr|day|week|month> <relative|absolute> [ hg|git log ...]``
