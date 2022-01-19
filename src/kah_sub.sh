#! /bin/bash

#### FUNÇÕES ####

subfnder() {

  read -p 'identify the domain: ' domain
  while :
  do
      subfinder -d $domain -silent | anew tmp/subdomains.txt 
    sleep 3600
  done
}

asetfinder() {

  read -p 'identify the domain: ' domain
  while :
  do
      assetfinder -subs-only $domain | anew tmp/subdomains.txt 
    sleep 3600
  done
}

findmain() {

  read -p 'identify the domain: ' domain
  while :
  do
      findomain -t $domain -silent | anew tmp/subdomains.txt 
    sleep 3600
  done
}

validateUrls() {

  file="tmp/subdomains_unresolved.txt"
  mv tmp/subdomains.txt $file

    cat $file | httpx -silent | anew tmp/subdomains.txt 
}
takover() {

   python3 takeover.py -l ./tmp/subdomains.txt -v -t 5  | anew ./tmp/takeover_vul.txt
}
#### END FUNCTIONS ####


echo "
────────────────────────────────────────────────
─██████──████████─██████████████─██████──██████─
─██░░██──██░░░░██─██░░░░░░░░░░██─██░░██──██░░██─
─██░░██──██░░████─██░░██████░░██─██░░██──██░░██─
─██░░██──██░░██───██░░██──██░░██─██░░██──██░░██─
─██░░██████░░██───██░░██████░░██─██░░██████░░██─
─██░░░░░░░░░░██───██░░░░░░░░░░██─██░░░░░░░░░░██─
─██░░██████░░██───██░░██████░░██─██░░██████░░██─
─██░░██──██░░██───██░░██──██░░██─██░░██──██░░██─
─██░░██──██░░████─██░░██──██░░██─██░░██──██░░██─
─██░░██──██░░░░██─██░░██──██░░██─██░░██──██░░██─
─██████──████████─██████──██████─██████──██████─
──────────────────────────────────────────────── "
echo "
Procurará por domínio e escreverá tmp/subdomains.txt

0 - Subfinder 
1 - Assetfinder
2 - Findomain

10 - validar URLs
11 - Takeouver
"

read -p 'Escolha seu serviço: ' service

case $service in
  '0' | 0)
    subfnder
    ;;
  '1' | 1)
    asetfinder
    ;;
  '2' | 2)
    findmain
    ;;
  '10' | 10)
    validateUrls
    ;;
  '11' | 11)
    takover
    ;;
esac
