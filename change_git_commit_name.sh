#!/bin/sh

git filter-branch --env-filter 'if [ "$GIT_AUTHOR_EMAIL" = "thomas@schoengassner.at" ]; then
GIT_AUTHOR_EMAIL=tschoengassner@aidminutes.com;
GIT_AUTHOR_NAME="Thomas"
GIT_COMMITTER_EMAIL=$GIT_AUTHOR_EMAIL;
GIT_COMMITTER_NAME="$GIT_AUTHOR_NAME"; fi' -- --all

"""
git log --pretty=format:"%h%x09%an %ae%x09%ad%x09%s"
git log --pretty=format:"%h %an %ae %ad %s"

"""
#