#! /bin/bash

# ### FUNÇÕES ####

subfnder() {
  figlet Subfinder

  read -p 'identify the domain: ' domain
  while :
  do
    if [ "$notify_enabled" == "false" ]
    then
      subfinder -d $domain -silent | anew tmp/subdomains.txt 
    else
      subfinder -d $domain -silent | anew tmp/subdomains.txt | notify -silent
    fi
    sleep 3600
  done
}

asetfinder() {
  figlet Assetfinder

  read -p 'identify the domain: ' domain
  while :
  do
    if [ "$notify_enabled" == "false" ]
    then
      assetfinder -subs-only $domain | anew tmp/subdomains.txt 
    else
      assetfinder -subs-only $domain | anew tmp/subdomains.txt | notify -silent
    fi
    sleep 3600
  done
}

findmain() {
  figlet findomain

  read -p 'identify the domain: ' domain
  while :
  do
    if [ "$notify_enabled" == "false" ]
    then
      findomain -t $domain -silent | anew tmp/subdomains.txt 
    else
      findomain -t $domain -silent | anew tmp/subdomains.txt | notify -silent
    fi
    sleep 3600
  done
}

validateUrls() {
  figlet HTTPX

  file="tmp/subdomains_unresolved.txt"
  mv tmp/subdomains.txt $file

  if [ "$notify_enabled" == "false" ]
  then
    cat $file | httpx -silent | anew tmp/subdomains.txt 
  else
    cat $file | httpx -silent | anew tmp/subdomains.txt | notify -silent
  fi

  rm -rf $file
}

#### END FUNCTIONS ####

figlet Kah

notify_enabled=$NOTIFY

echo "
Procurará por domínio e escreverá tmp/subdomains.txt

0 - Subfinder 
1 - Assetfinder
2 - Findomain

10 - validate URLS
15 - enable notify
"

read -p 'Choose your service: ' service

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
  '15' | 15)
    echo "run this: export NOTIFY=true"
    ;;
esac
