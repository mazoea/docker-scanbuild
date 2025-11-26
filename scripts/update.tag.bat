git push origin :v20
git tag -d v20
git tag v20
git push origin master --tags

IF "%1"=="nopause" GOTO No1
    pause
:No1 