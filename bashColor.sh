# Black        0;30     Dark Gray     1;30
# Red          0;31     Light Red     1;31
# Green        0;32     Light Green   1;32
# Brown/Orange 0;33     Yellow        1;33
# Blue         0;34     Light Blue    1;34
# Purple       0;35     Light Purple  1;35
# Cyan         0;36     Light Cyan    1;36
# Light Gray   0;37     White         1;37

R='\033[0;31m'          #red
RB="\033[1;31m"         #red blod
r='\033[0;31m'          #red
rb="\033[1;31m"         #red blod
G='\033[0;32m'          #green
GB="\033[1;32m"         #green blod
g='\033[0;32m'          #green
gb="\033[1;32m"         #green blod
B='\033[0;34m'          #blue
BB="\033[1;34m"         #blue blod
b='\033[0;34m'          #blue
bb="\033[1;34m"         #blue blod
Y='\033[0;33m'          #yellow
YB="\033[1;33m"         #yellow blod
y='\033[0;33m'          #yellow
yb="\033[1;33m"         #yellow blod



NC='\033[0m' # No Color

cecho ()
{
    echo -e "\n${!1}${2} ${NC}\n" >&3
}
