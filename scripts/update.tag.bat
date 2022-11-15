git push origin :v10
git tag -d v10
git tag v10
git push origin master --tags

IF "%1"=="nopause" GOTO No1
    pause
:No1 