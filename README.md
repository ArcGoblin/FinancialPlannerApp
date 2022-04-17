# FinancialPlannerApp
 App to aid financial planning

Conneting R Studio with Github
 https://rfortherestofus.com/2021/02/how-to-use-git-github-with-r/
 To generate a personal access token, use the create_github_token() function from usethis. This will take you to the appropriate page on the GitHub website, where you’ll give your token a name and copy it (don’t lose it because it will never appear again!). 
 After you’ve created a Personal Access Token, we need to store it so that RStudio can access it and know to connect to your GitHub account. The gitcreds_set() function from the gitcreds package will help you here. You’ll enter your GitHub username and the Personal Access Token as your password (NOT your GitHub password, as I initially thought). Once you’ve done all of this, you have connected RStudio to GitHub!
 
