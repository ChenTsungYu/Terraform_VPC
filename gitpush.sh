#!/bin/bash
echo "start git add!"
git add .
echo "start git commit!"
read -p "Please input your git commit: " commit
echo "Your commit is '${commit}'"
git commit -m "${commit}"
echo "start committing!"
git push
echo "Great!"
