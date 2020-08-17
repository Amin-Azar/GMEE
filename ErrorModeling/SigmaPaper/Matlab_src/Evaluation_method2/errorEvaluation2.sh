
source /CMC/scripts/altera.15.1.sh
file=$(zenity --file-selection)
echo "running for $file"
bash $file

