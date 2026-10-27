# מקורות תרגילי הבית

כל התרגילים נבנים מאותה תבנית, `infi-ex.cls`, ולכן נראים אחיד.

## For future exercises

1. `cd exercises/src`
2. `cp template.tex ex4.tex`
3. Fill in the number, topic and questions.
4. Run `make`. It creates `../ex4.pdf`.

## מה יש בתבנית

| פקודה | תפקיד |
|---|---|
| `\makeextitle` | פס הכותרת (קורס, מספר תרגיל, נושא, מועד הגשה) |
| `\exdue{...}` | מועד הגשה (אופציונלי) |
| `\begin{instructions}` | תיבת הנחיות; `[כותרת]` משנה את הכותרת |
| `\topic{...}` | כותרת ביניים לקבוצת שאלות |
| `\begin{question}` / `\begin{question}[כותרת][ניקוד]` | שאלה ממוספרת, עם כותרת וניקוד אופציונליים |
| `\begin{parts}` | סעיפים (א), (ב)…; מקוננים: 1., 2.… |
| `\R \N \Z \Q`, `\set{a}{b}` | קיצורי מתמטיקה |
| `\goodluck` | "בהצלחה!" בסוף התרגיל |
| `\input{axioms}` | נספח: טבלת אקסיומות הממשיים |

## דרישות

‏LuaLaTeX (`sudo apt install texlive-luatex texlive-latex-extra`).
הגופנים (Frank Ruhl Libre ו־Rubik, רישיון OFL) כלולים בתיקייה `fonts/` ואין צורך להתקין אותם.
