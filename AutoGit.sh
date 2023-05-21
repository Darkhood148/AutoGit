#!/bin/bash

function push_to_git {
  git init
  git add .
  echo "Commit Message?"
  read msg
  git commit -m "$msg"
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
        echo $username > $user_file
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
        user_file=".active_user_name.txt"
        if [[ -f $file_name && -f $user_file ]]; then
            token=$(cat $file_name)
        else
            echo "Looks like you are missing something."
            enter_credentials
        fi
        echo "Enter repo name"
        read repo_name
        echo "Enter repo description"
        read repo_description
        printf $token
        printf "\nCreating repo\n====================\n\n"
        curl -H "Authorization: token $token" --data "{\"name\":\"$repo_name\", \"description\":\"$repo_description\"}" https://api.github.com/user/repos
        printf "\n\n====================\nDone\n"
        echo "Enter \"y\" to make first commit."
        read ch
        if [[ $ch == "y" ]]; then
            username=$(cat $user_file)
            push_to_git $username $repo_name
        fi
    fi
done