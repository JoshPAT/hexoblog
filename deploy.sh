#!/bin/bash

hexo clean
hexo generate
hexo deploy
echo -e "INFO Changes will be effectives in few seconds.\nINFO Browser will be opened later.\n"
sleep 10s
open -a "Google Chrome" http://joshpat.github.io/