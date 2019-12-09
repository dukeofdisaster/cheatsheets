#!/bin/bash
#
# usage: converts jwt style base64 string to normal type: - => +, _ => /
echo -ne $1 | sed 's/\-/\+/g' |sed 's/\_/\//g'
