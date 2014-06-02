#!/bin/sh

DOC=ssh_context

pandoc -f markdown -t context --toc  --smart --standalone --template=../pandoc/zh.context ../mkd/ssh.mkd -o ${DOC}.tex
rm ${DOC}.pdf
context --purge
context ${DOC} && open ${DOC}.pdf

