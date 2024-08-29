#/bin/bash

mkdir tmp
cd tmp

URL=https://dadosabertos.rfb.gov.br/CNPJ/dados_abertos_cnpj/$(date '+%Y-%m')/

# Download public index
wget --no-parent -r $URL

wait $(jobs -p)

# unzip files
unzip *.zip

# Merge files with same type
cat *EMPRECSV > EMPRE.csv
cat *ESTABELE > ESTABELE.csv
cat *SOCIOCSV > SOCIO.csv

for file in *; do zip -rm -9 ${file%.*}.zip $file; done
