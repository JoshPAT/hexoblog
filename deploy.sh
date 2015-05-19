#!/bin/bash
hexo clean
hexo generate
hexo deploy

open -a "Google Chrome" http://joshpat.github.io/