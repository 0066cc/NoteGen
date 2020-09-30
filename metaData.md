---
title:
date:
author: YOUR NAME
top-level-division: default
toc: true
header-includes:
    - \usepackage{fancyhdr}
    - \usepackage{enumitem}
    - \usepackage{hyperref}
    - \usepackage{framed}
    - \usepackage{quoting}
    - \let\oldtoc\tableofcontents
    - \renewcommand{\tableofcontents}{\oldtoc\newpage}
    - \definecolor{bgcolor}{HTML}{ededed}
    - \colorlet{shadecolor}{bgcolor}
    - \newenvironment{shadedquotation}
      {\begin{shaded*}
       \quoting[leftmargin=0em, rightmargin=1pt, vskip=1pt, font=itshape]
      }
      {\endquoting
      \end{shaded*}
      }
    - \def\quote{\shadedquotation}
    - \def\endquote{\endshadedquotation}
    - \fancyhf{}
    - \pagestyle{fancy}
    - \fancyhead[C]{\leftmark}
    - \renewcommand{\refname}{ }
    - \fancyfoot[C]{\thepage}
    - \usepackage{microtype}
    - \setlength{\parskip}{2px}
    - \setlength{\parindent}{0cm}
    - \renewcommand*\familydefault{\sfdefault}
    - \let\oldtexttt\texttt
    - \renewcommand{\texttt}[1]{
       \colorbox{bgcolor}{\oldtexttt{#1}}
       }
toc-depth: 6
number-sections: true
documentclass: article
tab-stop: 4
papersize: a4paper
geometry: margin=1.2in
preserve-tabs: true
fontsize: 11pt
urlcolor: blue
incremental: true
---
