Què és
======
Un script / crawler per tal de poder descarregar en local tot el diari oficial de la Universitat de Girona (eBOU).

Motivació
=========
Per temes de matriculació, m'he trobat amb la necessitat de cercar si hi ha hagut una derogació d'un cert reglament que m'és d'interès.

He hagut d'elaborar aquest «crawler» per tal de poder baixar totes les entrades al diari localment i així poder fer cerques textuals ja que la funcionalitat de cerca actual de la web no funciona correctament i no és de fiar.

Ús responsable
==============
La descàrrega probablement suposarà una càrrega elevada de trànsit i processament per al servidor.

Useu l'script amb moderació per tal de no provocar interrupcions en el servei.

Anàlisi ètic
============
Entenc que és legítim poder buscar en una normativa pública i accessible per a tothom ja que és «llei interna» de la universitat i aplica a qualsevol membre de la comunitat universitària.

Els documents baixats no haurien de contenir informació personal; malauradament en moltes entrades, hi ha noms d'alumnes i treballadors entre molta altra informació que pot revelar aspectes de la vida de les persones.

Gran part d'aquesta informació hauria de ser reservada i no ser publicada indiscriminadament de forma oberta a internet on pot ser minada, indexada (i.e google) i qui sap a quins altres mals usos pot estar exposada en un futur.

Qui usi l'script hauria d'ignorar la informació que refereix a les persones de forma directa o indirecta.

Per prudència, és molt important que no es faci un mal ús ni es re-publiqui enlloc la informació descarregada.

Enginyeria inversa
==================
Cada publicació té associada una URL, que correspon a un document HTML:

	https://seu.udg.edu/ca-es/boudg/ebou?disposicio=1076

Els números del final són consecutius, van de 0 fins al més recent.

A cada document HTML hi han PDF's associats de l'estil:

	https://seu.udg.edu/portals/_default/xmlxst/seu/documents_BOU.asp?ID=26

Implementació
============

1. Es baixen tots els html i es desen a la carpeta actual (pwd).

2. Per cada html es cerca si hi ha enllaços cap a pdf, aquests es baixen i es desen a la carpeta actual (pwd).

3. Per cada pdf i html, es genera un document .txt amb el text visible per l'usuari per tal de poder fer cerques amb eines com el grep, agrep…

Ús
==

Els scripts escriuran els resultats en el directori de treball actual de la vostra línia d'ordres.

Si un fitxer existeix, l'script ho ignorarà i no farà una nova petició per baixar-lo.
Si voleu començar de nou cal que esborreu les carpetes i fitxers baixats.


1. Heu de determinar l'identificador màxim actual (mireu el número de l’última publicació que s’hagi fet a l’eBOU.

    ./boudg.bash [identificador mínim] [identificador màxim]

2. Feu cerques amb comandes com per exemple:

    agrep -iB -w -1 -e 'proteccio;dades' *.txt

Requeriments del sistema
========================
El desenvolupament d'aquest script s'ha fet en un sistema GNU/Linux Debian 10 Buster a data 2020-09-23.

Com a mínim cal disposar de les següents dependències:

    apt-get install wget parallel python3-pdfminer html2text

Llicència
=========
Copyright (C) 2020 (see Git author)

This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.
