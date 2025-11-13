git push origin :v18
git tag -d v18
git tag v18
git push origin master --tags

IF "%1"=="nopause" GOTO No1
    pause
:No1 