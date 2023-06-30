# https://stackoverflow.com/questions/5947742/how-to-change-the-output-color-of-echo-in-linux
# Black        0;30     Dark Gray     1;30
# Red          0;31     Light Red     1;31
# Green        0;32     Light Green   1;32
# Brown/Orange 0;33     Yellow        1;33
# Blue         0;34     Light Blue    1;34
# Purple       0;35     Light Purple  1;35
# Cyan         0;36     Light Cyan    1;36
# Light Gray   0;37     White         1;37

#    .---------- constant part!
#    vvvv vvvv-- the code from above

PURPLE='\033[0;35m'
NC='\033[0m' # No Color

clear

printf "${PURPLE}rubocop----code smells------------------------${NC}\n"
rubocop -A lib

printf "\n\n"
printf "${PURPLE}reek----code smells------------------------${NC}\n"
reek lib
v
printf "\n\n"
printf "${PURPLE}debride----potentially uncalled / dead methods------------------------${NC}\n"
debride lib

printf "\n\n"
printf "${PURPLE}flay----structural similarities------------------------${NC}\n"
flay lib

printf "\n\n"
printf "${PURPLE}fasterer----speed improvements------------------------${NC}\n"
fasterer lib
