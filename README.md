# Tex2utf8

Tcl utility that converts LaTeX diacritics of Western characters sets into their corresponding UTF8 codes 

Usage

package require tex2utf8

::TeX2utf8 convert {\'{a}\'{e}\'{i}\'{o}\'{u}\'{A}\'{E}\'{I}\'{O}\'{U}}

If your web page or shell has an UTF-8 based locale you should see the correct representation of
the characters

   supported LaTeX diacritical marks (example characters require UTF-8)

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
   - r letters with ogonek (as in ą) used in Polish and Lituanian 


