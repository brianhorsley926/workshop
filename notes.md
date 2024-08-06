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

## Checks out (creates) a new branch 
git checkout -b [branch_name]

## Pushes the new branch commit to GitHub - This is where you make PR's + merge??
git push -u origin main [branch_name]


# 8/6 Notes
- puts is a method that renders the contents of a variable and returns nil every time
- We are able to check for gems that we can use in a ruby script using "gem list" in the cmd line
  - To add an additional gem, use "gem install [gem_name]"
  - e.g. "pry" is a gem that allows you to stop code at a specific line and interact with your script in the cmd line
    - Use "binding.pry" after the line of code you would like to test
    - Type "exit" in the cmd line to move past the binding.pry in the script
    - To exit many bindings, use "exit!"
- String conventions:
  - Use '' for string-only variables e.g. 'string value'
  - Use "" for string interpolation e.g. "This is my favorite #{variable_name}"

