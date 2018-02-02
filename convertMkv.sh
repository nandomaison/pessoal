if [ "$1" == "-h" ] || [ "$1" == "--help" ];then
	echo "Script que converte todos os MPG de um diretório em MKV"
	exit 0
fi

function converte(){
	nome=$(echo $i | awk -F "." '{print $1}')
	ffmpeg -i ${i} ${nome}.mkv

}
#diretorio=$1
numberFiles=$(ls ${diretorio}/*.MPG | wc -l)
atual=0
for i in $(ls ${diretorio}/*.MPG);do
	let atual=$atual+1;
	echo "${atual}/$numberFiles - Processando ${i}... "
	nome=$(echo $i | awk -F "." '{print $1}') 
	ffmpeg -i ${i} ${nome}.mkv
	rm -f ${i}
done