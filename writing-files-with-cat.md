# WRITING FILES WITH CAT
Sometimes you'll find yourself in a restricted shell that's not fully interactive
and it will be hard to write files and continue hacking away. This is 
where knowing some cat magic comes in handy. Check the example below. 
Note that: EOF is an arbitrary string in the example below that just signals
the end of input to cat; it could be anything we wanted it to be; the 
point being that to finish writing whatever we want, we just supply the 
terminating string and what's done is done. 

```
user@computer:~$ cat <<EOF>test.txt
> hello
> hello
> hello
> hello
> test
> EOF
user@computer:~$ cat test.txt 
hello
hello
hello
hello
test
user@computer:~$ cat <<EOF>>test.txt
> test appending to this file
> EOF
user@computer:~$ cat test.txt 
hello
hello
hello
hello
test
test appending to this file
user@computer:~$ contents=$(cat test.txt)
user@computer:~$ cat <<EOF>test.txt
> I added these lines at the top
> by storing the old contents to a variable
> then overwriting the file
> and supplying the old contents 
> afterward
> $contents
> EOF
user@computer:~$ cat test.txt 
I added these lines at the top
by storing the old contents to a variable
then overwriting the file
and supplying the old contents 
afterward
hello
hello
hello
hello
test
test appending to this file
user@computer:~$ 
```
============================================
