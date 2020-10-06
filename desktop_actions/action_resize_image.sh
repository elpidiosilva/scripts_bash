#!/bin/bash
PERCENT=`zenity --scale --text "Informe a porcentagem do novo arquivo" --min-value=2 --max-value=100 --value=50 --step 2`

while (( "$#" )); do  
	## Tratamento do caminho e nome do arquivo
	#echo $@|zenity --text-info			# Debug
	#echo $1|zenity --text-info			# Debug

	fullpath=$1					# Caminho completo sem aspas, encaminhadas pelo Thunar
	filename="${fullpath##*/}"                      # Pega o nome do arquivo, considerando a última / encontrada no caminho
	dir="${fullpath:0:${#fullpath} - ${#filename}}" # Subtrai o nome do arquivo do caminho completo
	base="${filename%.[^.]*}"                       # Nome do arquivo sem extensão
	ext="${filename:${#base} + 1}"                  # Extensão do arquivo
	new_name="$dir$base"_"$PERCENT"_redimensionado."$ext"
	#echo $dir,$base,$filename,$ext|zenity --text-info #Debug
	convert "$1" -resize "$PERCENT%" -quality 100 "${new_name}" | zenity --progress --pulsate --auto-close --auto-kill --text "Redimensionando $1 ..."
	shift
done

exit 0