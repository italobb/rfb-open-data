#/bin/bash

mkdir tmp
cd tmp

URL=https://www.gov.br/receitafederal/pt-br/assuntos/orientacao-tributaria/cadastros/consultas/dados-publicos-cnpj

# Download public index
files=$( \
    curl -s $URL \
    | grep external-link \
    | sed -e's,^.*href="\(.*://[^"]*\).*$,\1,g' )

for f in ${files//\\n/}
do 
    echo "$(basename $f)"
    curl -s -L -C - -O $f &
done

wait $(jobs -p)

# Pack all files
tar -czf data.tgz *.zip     

# unzip files

# Merge files with same type
#cat *EMPRECSV.csv > FULL-EMPRECSV.csv
#cat *ESTABELE.csv > FULL-ESTABELE.csv
#cat *SOCIOCSV.csv > FULL-SOCIOCSV.csv

