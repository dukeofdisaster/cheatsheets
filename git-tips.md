# How to push to a git repo other than github
- create empty repo in the remote you want to push to
```
mkdir myalternate_repo
cd myalternate_repo
git init --bare
```

- add an alternative remote to push to
```
git remote add alt user@server:/path/to/git/repo.git
```
- NOTE: alt is just an arbitrary name for the remote

- remove an alternative 
```
git remote rm alt
```

- push to alt 
```
git push alt
```

# bug bounty: found .git in a url???
```
wget --mirror -I .git TARGET.COM/.git/ 
cd TARGET.COM/ 
git status
git checkout -- .
```
- downloads the remote repo
- checks the repo status
- restores deleated files

## standard .git/ directories/files
```
HEAD 
branches/
config
description
hooks/
index
info/
logs/
objects/
packe-refs
refs/
```

# Forking and Branches
AWS Code Commit
- Console -> Repositories -> Choose Your repository -> Create Branch

Create a Branch in Git
```
git checkout -b MyNewBranch
```
## Use Case
There's a repo in codecommit that you've been tasked with creating tests for.
You clone the repo down then execute the checkout command above. You make changes
then commit them back to the local branch. Now you have to push them back up to code commit.
```
git push origin MyNewBranch
````
To switch back to a master repo from a branch
```
git checkout master
```

# sh keys with github
After adding your pub key to your github account, check your connection with the following
```
ssh -T git@github.com
The authenticity of host 'github.com (192.30.255.112)' can't be established.
RSA key fingerprint is SHA256:nThbg6kXUpJWGl7E1IGOCspRomTxdCARLviKw6E5SY8.
Are you sure you want to continue connecting (yes/no)? yes
Warning: Permanently added 'github.com,192.30.255.112' (RSA) to the list of known hosts.
Hi dukeofdisaster! You've successfully authenticated, but GitHub does not provide shell access.
```
