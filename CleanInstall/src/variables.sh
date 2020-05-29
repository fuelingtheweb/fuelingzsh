FUELINGZSH=$HOME/.fuelingzsh
src=$cleanInstall/src
custom=$FUELINGZSH/custom
backups=$HOME/Documents/Backups

GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

info() {
    printf "${BLUE}${1}${NC}\n"
}

success() {
    printf "${GREEN}${1}${NC}\n"
}

pause() {
   read -sn 1 -r -p "Press any key to continue..."
   printf "\n"
}

break() {
    echo '--------------'
}

infoWithBreaks() {
    break
    info $1
    break
}

copyLicense() {
    cat $cleanInstall/custom/licenses/$1.txt | pbcopy
}

runStepIf() {
    read -p "$2 " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
        source $src/step-$1.sh
    fi
}
