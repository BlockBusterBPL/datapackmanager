echo "starting installer"
: ${DIALOG_OK=0}
: ${DIALOG_CANCEL=1}
: ${DIALOG_HELP=2}
: ${DIALOG_EXTRA=3}
: ${DIALOG_ITEM_HELP=4}
: ${DIALOG_ESC=255}
tmp_file=$(tempfile 2>/dev/null) || tmp_file=/tmp/test$$
trap "rm -f $tmp_file" 0 1 2 5 15

echo "Checking Required Libraries..."
if [ colortest ] ; then

else
echo "One or more libraries were not found! Make sure they are installed before you run this script!"
wait 3
exit 1
fi
dialog --checklist "Select Options To Install:" 10 40 4
