What's this?
======

```hpc-public-docs``` is a project to maintain the public documents for [High Performance Center in Shanghai Jiaotong University](http://hpc.sjtu.edu.cn/).

The generated documents resides in [```pdf```](pdf/) and [```wiki```](wiki/) dirs.

How do the text-processing tools work?
------

1. Write your documents in Markdown (```*.mkd```).
2. Process your Markdown source files with ```pandoc```, which will combine ```*.mkd``` and pandoc latex templates to generate ```*.tex``` source files.
3. Compile your ```*.tex``` files with ```xelatex``` to generate the final PDF files. 

How can I build the documents?
------

Before you start, you need to:

1. Install [pandoc](http://johnmacfarlane.net/pandoc/).
2. Install [TeXLive](http://www.tug.org/texlive/).

Then, write something in ```ssh.mkd``` and type ```make``` to see the output file ```ssh.pdf``` and ```ssh.wiki```.
	
	$ EDIT mkd/ssh.mkd
	$ make ssh.pdf ssh.wiki
	$ ls pdf/ssh.pdf
	$ ls wiki/ssh.wiki

TODO
------
* Translate all the documents into English.

Reference
------
* "LaTeX Document Class for Manuals in HPC Center of SJTU" <https://github.com/weijianwen/hpc-manual-class>
* "Cambridge University HPC Service: Quick Start" <http://www.hpc.cam.ac.uk/user/quickstart.html>
* "HPC Compendium: LSF" <https://doc.zih.tu-dresden.de/hpc-wiki/bin/view/Compendium/PlatformLSF>

LICENSE
------
[MIT License](LICENSE)

