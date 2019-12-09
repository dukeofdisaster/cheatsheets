# ssh tips
default priv key privs: 600, rw-------

## generate a lost pub key from priv key
ssh-keygen -y -f ~/.ssh/id_rsa > ~/.ssh/id_rsa.pub

## test github ssh access after copying .pub key into github settings
ssh -T git@github.com
git remote set-url origin git@github.com:dukeofdisaster/cheatsheets.git
- will allow us to push to remote
- [read more](https://gist.github.com/developius/c81f021eb5c5916013dc)
