#!/bin/bash

function push_to_git {
  git init
  git add .
  git commit -m "Initial Commit"
  git remote add origin "https://github.com/$1/$2.git"
  git push -u origin main
  printf "\n========Done========\n"
}

printf "~~~~~~~~Welcome To AutoGit~~~~~~~~\n\n"
printf "\n====================\n\n"
echo "Enter 1 to create new repository"
echo "Enter 2 to manage personal tokens"
echo "Enter anything else to exit"
printf "\n====================\n"
for (( ; ; ))
do
    read choice
    if [[ choice -eq 1 ]]; then
        file_name=".active_access_token.txt"
        if [[ -f $file_name ]]; then
            token=$(cat $file_name)
        else
            echo "Looks like you don't have any token. Please enter one to use."
            read token
            touch $file_name
            echo $token > $file_name
        fi
        echo "Enter repo name"
        read repo_name
        echo "Enter repo description"
        read repo_description
        printf "\nCreating repo\n====================\n\n"
        curl -H "Authorization: token $token" --data "{\"name\":\"$repo_name\", \"description\":\"$repo_description\"}" https://api.github.com/user/repos
        printf "\n\n====================\nDone\n"
    fi
done