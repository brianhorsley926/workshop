### JJ Workshop Notes

Topics 
- Git (Version Control)/GitHub
    - https://github.com/git-guides#what-is-git-written-in
- zshell
    - cd / ls / ls -la / mkdir / pwd / touch [filename]
- VSCode
    - code [name]
- Home Brew
    - brew install [name]
    - brew doctor (fixes $PATH order?)
- asdf (ruby version manager)
    - asdf local ruby [version] 
        - Sets the version of ruby in the specified directory/project. whereas global sets the version outside of the directory and as the default
- Code Kata
    - ATM (Assume hardware all works) (dont forget an exit logic)
    - Elevator



## echo adds the text into the file called README.md
echo "# workshop" >> README.md

## Starts up the repo branch in console
git init

## Puts the file into the staging area prior to commit
git add README.md

## Commits the branch with a message describing the commit contents
git commit -m "lorem ipsum"

## Updates the root branch to "main"
git branch -M main

## Sets the remote origin repo to the specified repo in GitHub
git remote add origin [clone url]

## Pushes the changes into the GitHub master repo
git push -u origin main
