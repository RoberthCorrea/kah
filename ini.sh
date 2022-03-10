#!/bin/bash

echo "Instalando Takeover"

wget -q https://raw.githubusercontent.com/m4ll0k/takeover/master/takeover.py

echo "Instalando ParamSpider"

cd ~/kah
git clone https://github.com/devanshbatham/ParamSpider
cd ~/kah/ParamSpider
pip3 install -r requirements.txt
cd ~/kah

bash
