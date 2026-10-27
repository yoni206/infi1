% infi-ex.cls — תבנית אחידה לתרגילי הבית באינפי 1 (בר־אילן, תשפ"ז)
% קומפילציה: lualatex (ראו README.md בתיקייה זו)
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{infi-ex}[2026/10/27 Infi 1 exercise sheet]

\LoadClass[11pt,a4paper]{article}

% ---------- שפה וגופנים ----------
\RequirePackage{iftex}
\ifLuaTeX\else
  \ClassError{infi-ex}{Compile with lualatex}{This class needs LuaLaTeX.}
\fi
\RequirePackage[english, bidi=basic, layout=tabular.lists]{babel}
\babelprovide[main, import]{hebrew}

% הגופנים נמצאים בתיקייה fonts/ שליד הקובץ הזה (רישיון OFL)
\edef\ex@fontdir{\directlua{
  tex.sprint((kpse.find_file("infi-ex.cls", "tex"):gsub("infi.ex.cls$", "fonts/")))}}
\edef\ex@fonts{%
  \noexpand\babelfont[hebrew]{rm}[Path=\ex@fontdir, Extension=.ttf,
    UprightFont=FrankRuhlLibre-Regular, BoldFont=FrankRuhlLibre-Bold,
    Scale=1.08]{FrankRuhlLibre}%
  \noexpand\babelfont[hebrew]{sf}[Path=\ex@fontdir, Extension=.ttf,
    UprightFont=Rubik-Regular, BoldFont=Rubik-Bold,
    FontFace={mb}{n}{Rubik-Medium}]{Rubik}}
\ex@fonts
\newcommand\mediumsf{\sffamily\fontseries{mb}\selectfont}

\RequirePackage{amsmath,amssymb,amsthm,mathtools}
\RequirePackage[a4paper, top=2.0cm, bottom=2.0cm, left=2.3cm, right=2.3cm,
                headheight=14pt, headsep=0.7cm, footskip=1.1cm]{geometry}
\RequirePackage[dvipsnames,table]{xcolor}
\RequirePackage{enumitem}
\RequirePackage{fancyhdr}
\RequirePackage{lastpage}
\RequirePackage{array}

% ---------- צבעים ----------
\definecolor{exaccent}{HTML}{1B3A5C}  % כחול כהה
\definecolor{exgold}{HTML}{C8963E}    % זהב
\definecolor{exlight}{HTML}{EEF3F8}   % רקע תיבות
\definecolor{exmuted}{HTML}{6B7280}   % טקסט משני
\definecolor{exrule}{HTML}{D5DCE4}    % קווים עדינים
\definecolor{exdark}{HTML}{1F2937}

% ---------- פרטי הקורס ----------
\newcommand\excourse{אינפי 1}
\newcommand\exuniversity{אוניברסיטת בר־אילן}
\newcommand\exsemester{סמסטר א' תשפ"ז}

% ---------- פרטי התרגיל (נקבעים בכל קובץ) ----------
\newcommand\exnumber[1]{\def\@exnumber{#1}}
\newcommand\extopic[1]{\def\@extopic{#1}}
\newcommand\exdue[1]{\def\@exdue{#1}}
\exnumber{?}\extopic{}\let\@exdue\@empty

% ---------- כותרות עמוד ----------
% בעברית babel הופך את הצדדים: L = ימין, R = שמאל
\newcommand\ex@foot{{\footnotesize\sffamily\color{exmuted}%
  עמוד \thepage\ מתוך \pageref{LastPage}}}
\pagestyle{fancy}
\fancyhf{}
\renewcommand\headrulewidth{0.4pt}
\renewcommand\headrule{{\color{exrule}\hrule height\headrulewidth}}
\fancyhead[L]{\footnotesize\sffamily\color{exmuted}בס"ד}
\fancyhead[R]{\footnotesize\sffamily\color{exmuted}%
  \excourse\ \textcolor{exgold}{\textbullet}\ תרגיל בית \@exnumber
  \ifx\@extopic\@empty\else\ \textcolor{exgold}{\textbullet}\ \@extopic\fi}
\fancyfoot[C]{\ex@foot}
\fancypagestyle{first}{%
  \fancyhf{}%
  \renewcommand\headrulewidth{0pt}%
  \fancyhead[L]{\footnotesize\sffamily\color{exmuted}בס"ד}%
  \fancyfoot[C]{\ex@foot}}

% ---------- כותרת התרגיל ----------
% (תיבות צבע פשוטות: tcolorbox/tikz נשברים בכיוון ימין־לשמאל)
\newlength\ex@pad
\setlength\ex@pad{16pt}
\newcommand\makeextitle{%
  \thispagestyle{first}%
  \par\noindent
  {\setlength\fboxsep{0pt}%
   \colorbox{exaccent}{\hspace{\ex@pad}%
    \begin{minipage}[c]{\dimexpr0.78\linewidth-\ex@pad\relax}
      \color{white}\sffamily
      \vspace{11pt}
      {\footnotesize\addfontfeature{LetterSpace=6}\color{exgold}%
        \excourse\ \textbullet\ \exuniversity\ \textbullet\ \exsemester}\par
      \vspace{8pt}
      {\fontsize{24}{28}\selectfont\bfseries
        \ifx\@extopic\@empty תרגיל בית \@exnumber\else\@extopic\fi}\par
      \vspace{4pt}
      {\small\color{white!80!exaccent}%
        \ifx\@extopic\@empty\else תרגיל בית \@exnumber\fi
        \ifx\@exdue\@empty\else
          \ifx\@extopic\@empty\else\ \textcolor{exgold}{\textbullet}\ \fi
          מועד הגשה: \@exdue\fi}\par
      \vspace{11pt}
    \end{minipage}%
    \begin{minipage}[c]{\dimexpr0.22\linewidth-\ex@pad\relax}
      \centering\sffamily\color{exgold}
      {\fontsize{60}{60}\selectfont\bfseries\@exnumber}
    \end{minipage}\hspace{\ex@pad}}}%
  \par\nointerlineskip\noindent{\color{exgold}\rule{\linewidth}{3pt}}%
  \par\vspace{0.5\baselineskip}}

% ---------- הנחיות / הערות ----------
\newsavebox\ex@box
\newenvironment{instructions}[1][הנחיות]{%
  \par\addvspace{4pt}\noindent
  \begin{lrbox}{\ex@box}%
  \begin{minipage}{\dimexpr\linewidth-3pt-2\ex@pad\relax}
    \vspace{9pt}%
    {\mediumsf\color{exaccent}#1}\par\vspace{2pt}\ignorespaces}%
  {\par\vspace{9pt}\end{minipage}\end{lrbox}%
  {\setlength\fboxsep{0pt}%
   \colorbox{exlight}{{\color{exgold}\vrule width 3pt}\hspace{\ex@pad}%
     \usebox\ex@box\hspace{\ex@pad}}}%
  \par\addvspace{10pt}}

% ---------- נושא (כותרת ביניים) ----------
\newcommand\topic[1]{%
  \par\addvspace{1.0\baselineskip}%
  {\sffamily\Large\bfseries\color{exaccent}#1\par}%
  \nopagebreak\vspace{-3pt}%
  \noindent{\color{exgold}\rule{2.2cm}{2.5pt}}\par
  \nopagebreak\vspace{-0.9\baselineskip}}

% ---------- שאלות ----------
% \begin{question}[כותרת][ניקוד]
\newcounter{question}
\newcommand\ex@qbadge{{\setlength\fboxsep{0pt}%
  \colorbox{exaccent}{\rule[-0.35em]{0pt}{1.35em}\hspace{0.55em}%
    \textcolor{white}{\mediumsf שאלה \thequestion}\hspace{0.55em}}}}
\NewDocumentEnvironment{question}{o o}{%
  \par\addvspace{0.85\baselineskip}%
  \refstepcounter{question}%
  \noindent\ex@qbadge
  \IfValueT{#1}{\hspace{0.6em}{\mediumsf\color{exaccent}#1}}%
  \hspace{0.6em}{\color{exrule}\leaders\hrule height 0.6pt\hfill}%
  \IfValueT{#2}{\hspace{0.6em}{\small\sffamily\color{exmuted}#2 נק'}}%
  \par\nopagebreak\vspace{4pt}\noindent\ignorespaces}%
  {\par}

% סעיפים: א, ב, ג... ; תת־סעיפים: 1, 2, 3...
\newcommand\heblet[1]{\ifcase#1\or א\or ב\or ג\or ד\or ה\or ו\or ז\or ח\or ט\or
  י\or יא\or יב\or יג\or יד\or טו\or טז\fi}
\newcommand\hebletcounter[1]{\expandafter\heblet\csname c@#1\endcsname}
\AddEnumerateCounter{\hebletcounter}{\heblet}{יד}
\newlist{parts}{enumerate}{2}
\setlist[parts,1]{label={\mediumsf\color{exaccent}\hebletcounter*.},
  ref={\hebletcounter*}, leftmargin=2em, itemsep=4pt, topsep=4pt}
\setlist[parts,2]{label={\sffamily\color{exmuted}\arabic*.}, leftmargin=1.8em,
  itemsep=3pt, topsep=3pt}
\setlist[itemize]{label={\color{exgold}\textbullet}, itemsep=2pt, topsep=3pt}

% ---------- סיום ----------
\newcommand\goodluck{%
  \par\vspace{2\baselineskip}%
  \begin{center}
    {\color{exgold}\rule[0.3em]{1.5cm}{0.6pt}}%
    \hspace{0.8em}{\mediumsf\color{exaccent}בהצלחה!}\hspace{0.8em}%
    {\color{exgold}\rule[0.3em]{1.5cm}{0.6pt}}
  \end{center}}

% ---------- כללי ----------
\setlength\parindent{0pt}
\setlength\parskip{4pt}
\linespread{1.1}
\allowdisplaybreaks
\renewcommand\arraystretch{1.25}
\setlength\abovedisplayskip{6pt}
\setlength\belowdisplayskip{6pt}

% קיצורי מתמטיקה נפוצים
\newcommand\R{\mathbb{R}}
\newcommand\N{\mathbb{N}}
\newcommand\Z{\mathbb{Z}}
\newcommand\Q{\mathbb{Q}}
\newcommand\set[2]{\left\{ #1 \;\middle|\; #2 \right\}}

\endinput
