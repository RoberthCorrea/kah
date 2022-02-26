#! /bin/bash

#### FUNÇÕES ####

subfnder() {

  read -p 'identifique o domínio: ' domain
  while :
  do
      subfinder -d $domain -silent | anew tmp/subdomains.txt 
    sleep 3600
  done
}

asetfinder() {

  read -p 'identifique o domínio: ' domain
  while :
  do
      assetfinder -subs-only $domain | anew tmp/subdomains.txt 
    sleep 3600
  done
}

findmain() {

  read -p 'identifique o domínio: ' domain
  while :
  do
      findomain -t $domain -silent | anew tmp/subdomains.txt 
    sleep 3600
  done
}

paraspider() {

  read -p 'identifique o domínio: ' domain
  while :
  do
       python3 ParamSpider/paramspider.py -d $domain
           cat output/*.txt | anew tmp/paramspider.txt
             rm -rf output/
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
nucei() {

   nuclei -l ./tmp/subdomains.txt | anew ./tmp/nuclei_vul.txt
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
3 - Paramspider

10 - Validar URLs
11 - Takeouver
12 - Nuclei
13 - xss_vul
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
  '3' | 3)
    paraspider
    ;;
  '10' | 10)
    validateUrls
    ;;
  '11' | 11)
    takover
    ;;
  '12' | 12)
    nucei
    ;;
   '13' | 13)
    ./src/kah_xss.sh
    ;;
esac
