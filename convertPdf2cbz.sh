#! /bin/bash
# -------
# Converte PDF de imagens em arquivo .CBR
# (para leitura com softwares com cbrpager, qcomicbook, etc...)
# Parametros: nome do arquivo PDF

RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # Nenhuma Cor
argumento="$1"
s=0

function converte_file(){
	nome=$(basename "$1" | awk -F "." '{print $1}')
	diretorio=$(dirname "$1")
	printf "Processando ${YELLOW}${1}${NC}...\n"
	mkdir "/tmp/${nome}"
	pdfimages -j "${1}" "/tmp/${nome}/${nome}"
	rar a -inul "${diretorio}/${nome}.cbr" "/tmp/${nome}/${nome}*.jpg"
	rm -rf "/tmp/$nome"
}

if [ "$argumento" = "" ]; then
	printf "Uso: $0 <nome_do_arquivo_com_path>.\nExemplo: ${RED}${0} /home/fulano/Superman00.pdf${NC}.\n"
	exit 0
fi

if [ -d "$argumento" ];then
	printf "o caminho especificado é um diretório.\n"
	printf "Tem certeza que deseja converter todos os arquivos pdf da pasta em cbr? [S/n]:";read resposta
	if [ "$resposta" == "n" ]||[ "$resposta" == "N" ] ; then
    	echo "Conversão cancelada pelo usuário."
      	exit 0
	else
		find ${argumento} -name '*' | while read file;do
    		tipo=$(file "${file}" | awk -F ": " '{print $2}' | awk -F "," '{print $1}')
    		if [ "$tipo" == "PDF document" ];then
				converte_file "${file}"
				let s=$(expr ${s} + 1)
				echo "${s} arquivo(s) convertido(s)..."
			fi
		done
    	printf "Os arquivos convertidos estão na pasta ${YELLOW}${argumento}${NC}.\n"
      	exit 0
	fi
fi

if [ ! -f "$1" ]; then
	printf "Parece que o arquivo ${YELLOW}${1}${NC} é ${RED}INEXISTENTE${NC}...\nVerifique e tente novamente.\n"
	exit 1
fi

tipo=$(file "$1" | awk -F ": " '{print $2}' | awk -F "," '{print $1}')

if [ "$tipo" != "PDF document" ];then
	printf "Parece que o arquivo ${YELLOW}${1}${NC} não é um arquivo PDF.\nVerifique e tente novamente.\n"
	exit 1
fi

converte_file "$1"