#/bin/bash

mkdir tmp
cd tmp

URL=https://dadosabertos.rfb.gov.br/CNPJ/dados_abertos_cnpj/$(date --date="$(date +'%Y-%m-01') - 1 month" '+%Y-%m')/

apt install -y wget2
# Download public index
wget2 --num-threads=16 --no-parent -r $URL

wait $(jobs -p)

# unzip files
unzip *.zip

# Merge files with same type
cat *EMPRECSV > EMPRE.csv
cat *ESTABELE > ESTABELE.csv
cat *SOCIOCSV > SOCIO.csv

for file in *; do zip -rm -9 ${file%.*}.zip $file; done
