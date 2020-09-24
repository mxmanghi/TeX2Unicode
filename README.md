# tex2unicode

Tcl utility that converts LaTeX diacritics of Western characters sets into their corresponding Unicode code points 

Usage

package require tex2unicode

::tex2unicode to\_unicode {\\'{a}\\'{e}\\'{i}\\'{o}\\'{u}\\'{A}\\'{E}\\'{I}\\'{O}\\'{U}}
<==
àèìòùÀÈÌÒÙ

   supported LaTeX diacritical marks. 

   - " umlaut
   - ^ circumflex
   - ' acute accent
   - ` grave accent
   - ~ tilde
   - c cedilla
   - = macron (solid line atop a character as in ā)
   - u breve (u shaped trait atop a character as in ă)
   - v caron (v shaped trait atop a character as in č)
   - . dot above a character
   - r ring over a letter (as in å)
   - H double acute accent as in Ő
   - k letters with ogonek (as in ą) used in Polish and Lituanian 


