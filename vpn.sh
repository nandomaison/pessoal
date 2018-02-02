t=$(whereis openvpn | awk -F ": " '{print $2}')
dir="/openvpn/"
arq="/openvpn/Conf_VPN_Ext_Nova2.ovpn"
if [ -z "$t" ];then
	echo "O pacote openvpn não está instalado."
	echo "Favor instala-lo com o comando: sudo apt install openvpn -y"
	echo "Logo em seguida coloque os arquivos de config adequados em ${dir}."
	exit 1
else
	if [ ! -d "$dir" ];then
		echo "Parece que o diretorio ${dir} nao existe..."
		echo "Crie e coloque os arquivos de config adequados em ${dir}."
		exit 1
	else 
		if [ ! -z "$dir" ];then
			if [ ! -e "$arq" ];then
				echo "${arq} nao existe!"
				echo "Verifique suas configracoes!"
				exit 1
			else
				#certificado=$(cat $arq | grep "^cert "| awk -F "cert " '{print $2}')
				#echo $certificado
				#if [ ! -r "${certificado}" ];then
				echo aqui estou
				if [ ! -r $(cat $arq | grep "^cert "| awk -F "cert " '{print $2}') ];then
					echo "Atualize ${arq} e tente novamente."
					echo "O arquivo de certificado ($certificado) nao existe ou esta inacessivel."
					echo $certificado
					exit 1
				else
					chave=$(cat $arq | grep "^key ")
					if [ ! -r "${chave}" ];then
						echo "Arquivo de chave (${chave}) não existe ou está inacessível."
						echo "Atualize ${arq} e tente novamente."
						exit 1
					else
						tls=$(cat $arq | grep "^tls-auth " | head -1)
						if [ ! -r "${tls}" ];then
							echo "Arquivo de tls (${tls}) não existe ou esta inacessível."
							echo "Atualize ${arq} e tente novamente."
							exit 1
						else
							echo "Iniciando processo de VPN..."
							# sudo openvpn --config '/openvpn/Conf_VPN_Ext_Nova2.ovpn'
						fi
					fi
				fi
			fi
		else
			echo "O diretorio /opnvpn/ encontra-se vazio."
			exit 1
		fi
	fi
fi