#!/bin/bash
directory=$(dirname "${BASH_SOURCE[0]}")
cd "${directory}"
directory=$(readlink -f ..)
page_directory="${directory}/gollum.wiki"
echo cd "${page_directory}"
cd "${page_directory}"
nohup gollum --mathjax --port 4567 &> /dev/null &

