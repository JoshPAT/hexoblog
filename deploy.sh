#!/bin/bash

hexo clean
hexo generate
hexo deploy
# echo -e "INFO Changes will be effectives in few seconds.\nINFO Browser will be opened later.\n"
# osascript -e 'tell app "Terminal"
#    do script "cd ~/Documents/hexoblog;hexo server"
# end tell'
# sleep 2s
# #open -a "Google Chrome" http://localhost:4000
