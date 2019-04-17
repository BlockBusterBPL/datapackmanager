# ErrorHandler
handle_dpm_errors(){
	: #TODO Do This
}
handle_dpc_errors(){
	clear
	yq read errors.yml "dpc.${1}.description.en" | echo
	fullerror="DPC: [ERROR] Code: ${1}; Description: ${errordesc}"
	echo "${fullerror}"
}
errorhandler(){
case $1 in
"dpm")
	handle_dpm_errors "$2"
	;;
"dpc")
	handle_dpc_errors "$2"
	;;
esac
}