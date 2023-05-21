#!/bin/bash

function push_to_git {
  git init
  git add .
  git commit -m "Initial Commit"
  git remote add origin "https://github.com/$1/$2.git"
  git push -u origin main
  printf "\n========Done========\n"
}
function enter_credentials {
        echo "Enter Token"
        read token
        touch $file_name
        echo $token > $file_name
        echo "Enter username associated with this token"
        read username
        echo $username >> $file_name
}

printf "~~~~~~~~Welcome To AutoGit~~~~~~~~\n\n"
printf "\n====================\n\n"
echo "Enter 1 to create new repository"
echo "Enter 2 to edit personal token"
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
            echo "Looks like you don't have any token."
            enter_credentials
        fi
        echo "Enter repo name"
        read repo_name
        echo "Enter repo description"
        read repo_description
        printf "\nCreating repo\n====================\n\n"
        curl -H "Authorization: token $token" --data "{\"name\":\"$repo_name\", \"description\":\"$repo_description\"}" https://api.github.com/user/repos
        printf "\n\n====================\nDone\n"
        echo "Enter \"y\" to make first commit."
        read ch
        if [[ $ch == "y" ]]; then
            username=$(cat $file_name | xargs | awk '{print $2}')
            push_to_git $username $repo_name
        fi
    fi
done