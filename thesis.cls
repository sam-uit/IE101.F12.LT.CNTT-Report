%%===========================================================================%%
%% This is file `thesis.cls', based on 'ECSthesis.cls', by Steve R. Gunn
%% Modernized for LuaLaTeX with native Unicode and Vietnamese support
%%
%% Originally created by Steve R. Gunn, modified by Sunil Patel
%% Modernized in 2025 to use LuaLaTeX
%%---------------------------------------------------------------------------%%
%% Key improvements:
%% - LuaLaTeX for native UTF-8 and Vietnamese support
%% - Modern fontspec for font management
%% - Babel/Polyglossia for proper language support
%% - Removed dependency on vieextsizes (no longer needed for 13pt font)
%% - Supports standard 10pt, 11pt, 12pt, and 13pt+ font sizes natively
%%
%%===========================================================================%%
\NeedsTeXFormat{LaTeX2e}[2020/02/01]
\ProvidesClass{thesis}
[2025/12/03 v2.0
Modernized LuaLaTeX document class for Vietnamese support]
% Engine note: this class is designed for LuaLaTeX (Unicode + fontspec).
% If you use `minted` for syntax highlighting, compile with:
%   lualatex --shell-escape thesis.tex
% `epstopdf` and `listings` are intentionally omitted for LuaLaTeX workflows.
\def\baseclass{book}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{\baseclass}}
\def\@checkoptions#1#2{
  \edef\@curroptions{\@ptionlist{\@currname.\@currext}}
  \@tempswafalse
  \@tfor\@this:=#2\do{
    \@expandtwoargs\in@{,\@this,}{,\@curroptions,}
  \ifin@ \@tempswatrue \@break@tfor \fi}
  \let\@this\@empty
  \if@tempswa \else \PassOptionsToClass{#1}{\baseclass}\fi
}
% Modern LaTeX supports 10-12pt natively; no need for vieextsizes workaround
\@checkoptions{12pt}{{10pt}{11pt}{12pt}{13pt}}
\PassOptionsToClass{a4paper}{\baseclass}
\ProcessOptions\relax
\LoadClass{\baseclass}
% Load hyperref early so commands like \texorpdfstring are available
% (some macros defined below use \texorpdfstring). Keep options
% tuned for LuaLaTeX (hluatex driver auto-detected).
\usepackage[
  bookmarks=true,
  bookmarksopen=true,
  bookmarksopenlevel=0,
  bookmarksnumbered=true,
  hypertexnames=false,
  colorlinks=true,
  linkcolor={blue},
  citecolor={green},
  filecolor={magenta},
  urlcolor={blue},
  pdfstartview={FitV},
  unicode=true,
  breaklinks=true
]{hyperref}
\newcommand\bhrule{\typeout{------------------------------------------------------------------------------}
}
% Font configuration for Vietnamese - required before polyglossia
\usepackage{fontspec}
% Modern language support using polyglossia (better for LuaLaTeX with
% extended languages)
\usepackage{polyglossia}
\setdefaultlanguage{vietnamese}
\setotherlanguage{english}
\usepackage[title, titletoc]{appendix}

\newcommand\Declaration[1]{
  \btypeout{Giới Thiệu}
  \addtotoc{Giới Thiệu}
  \thispagestyle{plain}
  %\null\vfil
  %\vskip 60\p@
  \begin{center}{\Large \sc Nhóm 1 (Alpha) \par}
  \end{center}
  %\vskip 60\p@
  {\normalsize #1}
  \vfil\vfil\null
  %\cleardoublepage
}

\newcommand\btypeout[1]{\bhrule\typeout{\space #1}\bhrule}
\def\today{\ifcase\month\or
  January\or February\or March\or April\or May\or June\or
  July\or August\or September\or October\or November\or December\fi
\space \number\year}
\usepackage{setspace}
\onehalfspacing
\setlength{\parindent}{0pt}
\setlength{\parskip}{2.0ex plus0.5ex minus0.2ex}
\usepackage[margin=20mm]{geometry}
\raggedbottom
\setlength{\topskip}{1\topskip \@plus 5\p@}
\doublehyphendemerits=10000       % No consecutive line hyphens.
\brokenpenalty=10000              % No broken words across columns/pages.
\widowpenalty=9999                % Almost no widows at bottom of page.
\clubpenalty=9999                 % Almost no orphans at top of page.
\interfootnotelinepenalty=9999    % Almost never break footnotes.
\usepackage{fancyhdr}
\lhead[\rm\thepage]{\fancyplain{}{\sl{\rightmark}}}
\rhead[\fancyplain{}{\sl{\leftmark}}]{\rm\thepage}
\chead{}
\cfoot{}
\pagestyle{fancy}
% Make headheight slightly larger to avoid repeated fancyhdr warnings
\setlength{\headheight}{14.2pt}
\renewcommand{\chaptermark}[1]{\btypeout{\thechapter\space
#1}\markboth{\@chapapp\ \thechapter\ #1}{\@chapapp\ \thechapter\ #1}}
\renewcommand{\sectionmark}[1]{}
%
\renewcommand{\subsectionmark}[1]{}
\def\cleardoublepage{\clearpage\if@twoside \ifodd\c@page\else
  \hbox{}
  \thispagestyle{empty}
  \newpage
\if@twocolumn\hbox{}\newpage\fi\fi\fi}
%urlcol
\usepackage{amsmath,amsfonts,amssymb,amscd,amsthm,xspace}
% Common packages: moved from `thesis.tex` to centralize preamble
\usepackage{blindtext}
\usepackage[all]{hypcap}
\usepackage{paralist}
\usepackage{eqparbox}
\usepackage{array}
\usepackage{multirow}
\usepackage{tabularx}
\usepackage{float}
\usepackage{calc}
\usepackage{tocloft}
\theoremstyle{plain}
\newtheorem{example}{Example}[chapter]
\newtheorem{theorem}{Theorem}[chapter]
\newtheorem{corollary}[theorem]{Corollary}
\newtheorem{lemma}[theorem]{Lemma}
\newtheorem{proposition}[theorem]{Proposition}
\newtheorem{axiom}[theorem]{Axiom}
\theoremstyle{definition}
\newtheorem{definition}[theorem]{Definition}
\theoremstyle{remark}
\newtheorem{remark}[theorem]{Remark}
\usepackage[centerlast,small,sc]{caption}
\setlength{\captionmargin}{20pt}
\newcommand{\fref}[1]{Figure~\ref{#1}}
\newcommand{\tref}[1]{Table~\ref{#1}}
\newcommand{\eref}[1]{Equation~\ref{#1}}
\newcommand{\cref}[1]{Chapter~\ref{#1}}
\newcommand{\sref}[1]{Section~\ref{#1}}
\newcommand{\aref}[1]{Appendix~\ref{#1}}
\renewcommand{\topfraction}{0.85}
\renewcommand{\bottomfraction}{.85}
\renewcommand{\textfraction}{0.1}
\renewcommand{\dbltopfraction}{.85}
\renewcommand{\floatpagefraction}{0.75}
\renewcommand{\dblfloatpagefraction}{.75}
\setcounter{topnumber}{9}
\setcounter{bottomnumber}{9}
\setcounter{totalnumber}{20}
\setcounter{dbltopnumber}{9}
% Modern graphics support (pdftex no longer needed with LuaLaTeX)
\usepackage{graphicx}
\usepackage{minted}
\usepackage{booktabs}
\usepackage{rotating}
% Note: `listings` removed in favor of `minted` (Pygments). Remove `epstopdf`
% because LuaLaTeX supports common image formats natively.

\pdfstringdefDisableCommands{
  \let\\\space
}
\newcommand*{\supervisor}[1]{\def\supname{#1}}
\newcommand*{\examiner}[1]{\def\examname{#1}}
\newcommand*{\degree}[1]{\def\degreename{#1}}
\newcommand*{\authors}[1]{\def\authornames{#1}}
\newcommand*{\addresses}[1]{\def\addressnames{#1}}
\newcommand*{\university}[1]{\def\univname{#1}}
\newcommand*{\UNIVERSITY}[1]{\def\UNIVNAME{#1}}
\newcommand*{\department}[1]{\def\deptname{#1}}
\newcommand*{\DEPARTMENT}[1]{\def\DEPTNAME{#1}}
\newcommand*{\group}[1]{\def\groupname{#1}}
\newcommand*{\GROUP}[1]{\def\GROUPNAME{#1}}
\newcommand*{\faculty}[1]{\def\facname{#1}}
\newcommand*{\FACULTY}[1]{\def\FACNAME{#1}}
\newcommand*{\subject}[1]{\def\subjectname{#1}}
\newcommand*{\keywords}[1]{\def\keywordnames{#1}}
%%===========================================================================%%
% Added by  xuansamdinh
%------------------------------------------------------------------------------
\newcommand*{\projectname}[1]{\def\projname{#1}}
\newcommand*{\instructor}[1]{\def\instructorname{#1}}
\newcommand*{\INSTRUCTOR}[1]{\def\INSTRUCTORNAME{#1}}
\newcommand*{\student}[1]{\def\studentname{#1}}
\newcommand*{\STUDENT}[1]{\def\STUDENTNAME{#1}}
\newcommand*{\class}[1]{\def\classname{#1}}
\newcommand*{\schoolyear}[1]{\def\schyear{#1}}
%%===========================================================================%%
\supervisor  {}
\examiner    {}
\degree      {}
\authors     {}
\university  {\texorpdfstring{\href{http://www.example.com}
  {TRƯỜNG ĐẠI HỌC CÔNG NGHỆ THÔNG TIN}}
{TRƯỜNG ĐẠI HỌC CÔNG NGHỆ THÔNG TIN}}
\UNIVERSITY  {\texorpdfstring{\href{http://www.example.com}
{ĐẠI HỌC QUỐC GIA TP HỒ CHÍ MINH}}{ĐẠI HỌC QUỐC GIA TP HỒ CHÍ MINH}}
\department  {\texorpdfstring{\href{Department or School Web Site URL
    Here (include http://)}
  {Department or School Name}}
{Department or School Name}}
\DEPARTMENT  {\texorpdfstring{\href{Department or School Web Site URL
    Here (include http://)}
  {TRƯỜNG ĐẠI HỌC CÔNG NGHỆ THÔNG TIN}}
{TRƯỜNG ĐẠI HỌC CÔNG NGHỆ THÔNG TIN}}
\group       {\texorpdfstring{\href{Research Group Web Site URL Here
    (include http://)}
  {Research Group Name}}
{Research Group Name}}
\GROUP       {\texorpdfstring{\href{Research Group Web Site URL Here
    (include http://)}
  {RESEARCH GROUP NAME (IN BLOCK CAPITALS)}}
{RESEARCH GROUP NAME (IN BLOCK CAPITALS)}}
\faculty     {\texorpdfstring{\href{Faculty Web Site URL Here (include http://)}
  {Faculty Name}}
{Faculty Name}}
\FACULTY     {\texorpdfstring{FACULTY NAME (IN BLOCK CAPITALS)}}
\addresses   {}
\subject     {A project subject}
\keywords    {}
\renewcommand\maketitle{
  \btypeout{Title Page}
  \hypersetup{pdftitle={\@title}}
  \hypersetup{pdfsubject=\subjectname}
  \hypersetup{pdfauthor=\authornames}
  \hypersetup{pdfkeywords=\keywordnames}
  \thispagestyle{empty}
  \begin{titlepage}
    \let\footnotesize\small
    \let\footnoterule\relax
    \let \footnote \thanks
    \setcounter{footnote}{0}
    \null\vfil
    \vskip 60\p@
    \begin{center}
      \setlength{\parskip}{0pt}
      {\Large\textbf{\UNIVNAME}\par}
      {\LARGE\textbf{\univname}\par}
      \vfill
      {\Huge \bf \@title \par}
      \bigskip
      {\Large \bf \projname \par}
      \bigskip
      \vfill
      {
        \begin{minipage}{0.4\textwidth}
          \bf {Giảng Viên Hướng Dẫn:}\\
          \bf {Sinh Viên Thực Hiện:}\\
          \bf {Lớp:}\\
          \bf {Mã Môn:}\\
          \bf {Tên Môn:}
        \end{minipage}
        \begin{minipage}{0.4\textwidth}
          \bf {\INSTRUCTORNAME}\\
          \bf {\STUDENTNAME}\\
          \bf {\classname}\\
          \bf {\DEPTNAME}\\
          \bf {\deptname}
      \end{minipage}}
      \vfill
      {\large \bf \addressnames, \@date \par}
      \bigskip
    \end{center}
    %
    \par
    \@thanks
    \vfil\null
  \end{titlepage}
  \setcounter{footnote}{0}%
  \global\let\thanks\relax
  \global\let\maketitle\relax
  \global\let\@thanks\@empty
  \global\let\@author\@empty
  \global\let\@date\@empty
  \global\let\@title\@empty
  \global\let\title\relax
  \global\let\author\relax
  \global\let\date\relax
  \global\let\and\relax
  \cleardoublepage
}
%==============================================================================
\newenvironment{abstract}
{
  \btypeout{Abstract Page}
  \thispagestyle{empty}
  \null\vfil
  \begin{center}
    \setlength{\parskip}{0pt}
    {\large \UNIVNAME \par}
    {\Large \univname \par}
    \bigskip
    {\huge{\textit{Tóm Tắt}} \par}
    \bigskip
    \bigskip
    {\normalsize Graduation Thesis\par}
    \bigskip
    {\normalsize\bf \@title \par}
    \medskip
    {\normalsize by \authornames \par}
    \bigskip
  \end{center}
}
%==============================================================================
{
  \vfil\vfil\vfil\null
  \cleardoublepage
}
%==============================================================================
\addtocounter{secnumdepth}{1}
\setcounter{tocdepth}{6}
\newcounter{dummy}
\newcommand\addtotoc[1]{
  \refstepcounter{dummy}
\addcontentsline{toc}{chapter}{#1}}
%==============================================================================
\renewcommand\tableofcontents{
  \btypeout{Mục Lục}
  \addtotoc{Mục Lục}
  \begin{spacing}{1}{
      \setlength{\parskip}{1pt}
      \if@twocolumn
      \@restonecoltrue\onecolumn
      \else
      \@restonecolfalse
      \fi
      \chapter*{\contentsname
        \@mkboth{
      \MakeUppercase\contentsname}{\MakeUppercase\contentsname}}
      \@starttoc{toc}
      \if@restonecol\twocolumn\fi
      \cleardoublepage
    }
  \end{spacing}
}
%==============================================================================
\renewcommand\listoffigures{
  \btypeout{Danh Sách Hình Vẽ}
  \addtotoc{Danh Sách Hình Vẽ}
  \begin{spacing}{1}{
      \setlength{\parskip}{1pt}
      \if@twocolumn
      \@restonecoltrue\onecolumn
      \else
      \@restonecolfalse
      \fi
      \chapter*{\listfigurename
        \@mkboth{\MakeUppercase\listfigurename}
      {\MakeUppercase\listfigurename}}
      \@starttoc{lof}
      \if@restonecol\twocolumn\fi
      \cleardoublepage
    }
  \end{spacing}
}
%==============================================================================
\renewcommand\listoftables{
  \btypeout{Danh Sách Bảng}
  \addtotoc{Danh Sách Bảng}
  \begin{spacing}{1}{
      \setlength{\parskip}{1pt}
      \if@twocolumn
      \@restonecoltrue\onecolumn
      \else
      \@restonecolfalse
      \fi
      \chapter*{\listtablename
        \@mkboth{
      \MakeUppercase\listtablename}{\MakeUppercase\listtablename}}
      \@starttoc{lot}
      \if@restonecol\twocolumn\fi
      \cleardoublepage
    }
  \end{spacing}
}
%==============================================================================
%
% \renewcommand{\listoflistings}{
% \btypeout{List of }
%------------------------------------------------------------------------------
\newcommand\listsymbolname{Danh Sách Viết Tắt}
\usepackage{longtable}
\newcommand\listofsymbols[2]{
  \btypeout{\listsymbolname}
  \addtotoc{\listsymbolname}
  \chapter*{\listsymbolname
    \@mkboth{
  \MakeUppercase\listsymbolname}{\MakeUppercase\listsymbolname}}
  \begin{longtable}[c]{#1}#2
  \end{longtable}\par
  \cleardoublepage
}
%==============================================================================
\newcommand\listconstants{Physical Constants}
\usepackage{longtable}
\newcommand\listofconstants[2]{
  \btypeout{\listconstants}
  \addtotoc{\listconstants}
  \chapter*{\listconstants
    \@mkboth{
  \MakeUppercase\listconstants}{\MakeUppercase\listconstants}}
  \begin{longtable}[c]{#1}#2
  \end{longtable}\par
  \cleardoublepage
}
%==============================================================================
\newcommand\listnomenclature{Symbols}
\usepackage{longtable}
\newcommand\listofnomenclature[2]{
  \btypeout{\listnomenclature}
  \addtotoc{\listnomenclature}
  \chapter*{\listnomenclature
    \@mkboth{
  \MakeUppercase\listnomenclature}{\MakeUppercase\listnomenclature}}
  \begin{longtable}[c]{#1}#2
  \end{longtable}\par
  \cleardoublepage
}
%==============================================================================
\newcommand\reviews[1]{
  \btypeout{Nhận Xét}
  \addtotoc{Nhận Xét}
  \thispagestyle{plain}
  \begin{center}
    {\Large{\textbf{NHẬN XÉT}} \par}
  \end{center}
  {\normalsize #1}
  \vfil\vfil\null
}
%==============================================================================

\newcommand\acknowledgements[1]{
  \btypeout{Lời Cảm Ơn}
  \addtotoc{Lời Cảm Ơn}
  \thispagestyle{plain}
  \begin{center}{\Large{\textbf{LỜI CẢM ƠN}} \par}
  \end{center}
  {\normalsize #1}
  \vfil\vfil\null
}
%==============================================================================
\usepackage[xindy,nonumberlist,toc]{glossaries}
\newcommand\printglossarieshere[1]{
  \btypeout{Thuật Ngữ Và Từ Viết Tắt}
  \renewcommand*{\glossaryname}{Thuật Ngữ Và Từ Viết Tắt}
  \renewcommand*{\glsgroupskip}{}
  \renewcommand*{\arraystretch}{1}% default is 1
  \glsaddall
  \printglossaries
  \clearpage
}
%==============================================================================
\newcommand\dedicatory[1]{
  \btypeout{Dedicatory}
  \thispagestyle{plain}
  \null\vfil
  \vskip 60\p@
  \begin{center}{\Large \sl #1}
  \end{center}
  \vfil\null
  \cleardoublepage
}
%==============================================================================
\renewcommand\listingscaption{Code}
%==============================================================================
\renewcommand\backmatter{
  \if@openright
  \cleardoublepage
  \else
  \clearpage
  \fi
  \addtotoc{\bibname}
  \btypeout{\bibname}
\@mainmatterfalse}
\endinput
%
%==============================================================================
%% End of file `thesis.cls'.
%==============================================================================
