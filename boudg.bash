#!/bin/bash
# Copyright (C) 2020 (see Git author)
# 
# This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.

MIN_ID=${1:-1}
MAX_ID=${2:-10}

BASE_URL='https://seu.udg.edu/ca-es/boudg/ebou?disposicio='
PDF_BASE_URL='https://seu.udg.edu/portals/_default/xmlxst/seu/documents_BOU.asp?ID='
# Amount of parallelelism, be careful with the number of download jobs.
DOWNLOAD_JOBS=2
CPU_JOBS=16

for NUM in $(seq -f "%06g" $MAX_ID -1 $MIN_ID)
do
    echo wget -nc -O $NUM.html "$BASE_URL$NUM"
done | parallel --jobs $DOWNLOAD_JOBS


for HTML_FILE in `ls *.html`
do
    for PDF_ID in `grep -oE 'documents_BOU.asp\?ID=[[:digit:]]+' $HTML_FILE | grep -oE '[[:digit:]]+'`
    do
        echo wget -nc -O $HTML_FILE.$PDF_ID.pdf "$PDF_BASE_URL$PDF_ID"
    done
done | parallel --jobs $DOWNLOAD_JOBS

for HTML_FILE in `ls *.html`
do
    
    if [ -f $HTML_FILE.txt ]
    then
        echo echo Skipping. $HTML_FILE.txt already exists.
    else
        echo html2text -o $HTML_FILE.txt $HTML_FILE
    fi
done | parallel --jobs $CPU_JOBS

for PDF_FILE in `ls *.pdf`
do
    if [ -f $PDF_FILE.txt ]
    then
        echo echo Skipping. $PDF_FILE.txt already exists.
    else
        echo pdf2txt -o $PDF_FILE.txt $PDF_FILE
    fi
done | parallel --jobs $CPU_JOBS
