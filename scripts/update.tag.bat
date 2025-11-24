git push origin :v19
git tag -d v19
git tag v19
git push origin master --tags

IF "%1"=="nopause" GOTO No1
    pause
:No1 