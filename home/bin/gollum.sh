#!/bin/bash
page_directory=~/gollum.wiki
echo cd "${page_directory}"
cd "${page_directory}"
nohup gollum --mathjax --port 4567 &> /dev/null &

