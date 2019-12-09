# ssh tips
default priv key privs: 600, rw-------

## generate a lost pub key from priv key
ssh-keygen -y -f ~/.ssh/id_rsa > ~/.ssh/id_rsa.pub
