Public Documents from HPCC in SJTU
======

```hpc-public-docs``` is a project to host public documents from [Center for High Performance Center in Shanghai Jiaotong University](http://hpc.sjtu.edu.cn/). The online wiki version can be viewed via <http://pi.sjtu.edu.cn/docs>.

Build
------

The following prerequisites should be met. The document [docflow.mkd](mkd/docflow.mkd) illustrates how to set up the Pandoc+TeX environment.

* Pandoc
* TeXLive distribution with support to ConTeXt
* TeX Gyre font and Adobe Chinese fonts 

Clone the project:

	$ git clone https://github.com/sjtuhpcc/hpc-public-docs.git

Build the sample document:

	$ make sample.pdf sample.wiki sample.docx 

Build other documents:

	$ make ssh.pdf codesample.wiki

Build documents:

	$ make all

Feedback
------

Please send your feedback to [github issues](https://github.com/sjtuhpcc/hpc-public-docs/issues).

LICENSE
------
[MIT License](LICENSE)

