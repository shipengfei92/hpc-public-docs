%==================================================
%% hpcmanual.cls for manual documentation in HPC center of SJTU
%% Encoding: UTF-8
%% ==================================================

\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{hpcmanual.cls}[2013/07/06 v0.1 hpcmanual document class]
\newif\ifhpc@typeinfo \hpc@typeinfotrue
\DeclareOption{notypeinfo}{\hpc@typeinfofalse}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{ctexart}}
\ProcessOptions
\LoadClass[fancyhdr,fntef,UTF8,adobefonts]{ctexart}[2005/11/25]

%% Import hpcmanual.cfg file
\AtEndOfPackage{\makeatletter\input{hpcmanual.cfg}\makeatother}

%% XeTeX Fonts Specification
\RequirePackage{fontspec}
\setmainfont{TeX Gyre Termes}

%% Page Layout
\oddsidemargin 1.5 true cm
\if@twoside
  \evensidemargin 0 true cm
\else
  \evensidemargin 1.5 true cm
\fi
\textheight 21 true cm
\textwidth 14.5 true cm
\headheight 15pt
\parskip 0.5ex plus 0.25ex minus 0.25ex
\addtolength{\voffset}{-0.5cm}

%% Longtable
\RequirePackage{longtable}

%% End of file hpcmanual.cls
\endinput
