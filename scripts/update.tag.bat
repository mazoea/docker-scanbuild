git push origin :v6.0
git tag -d v6.0
git tag v6.0
git push origin master --tags

IF "%1"=="nopause" GOTO No1
    pause
:No1 