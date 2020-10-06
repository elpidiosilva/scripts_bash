#!/bin/bash
##
## Separa as páginas dos PDFs selecionados em arquivos distintos. Útil para fazer colagem de documentos com arquivos PDF.
##

while (( "$#" )); do
	## Tratamento do caminho e nome do arquivo
	fullpath=$1					# Caminho completo sem aspas, encaminhadas pelo Thunar
	filename="${fullpath##*/}"                      # Pega o nome do arquivo, considerando a última / encontrada no caminho
	dir="${fullpath:0:${#fullpath} - ${#filename}}" # Subtrai o nome do arquivo do caminho completo
	base="${filename%.[^.]*}"                       # Nome do arquivo sem extensão
	ext="${filename:${#base} + 1}"                  # Extensão do arquivo
	agora=$(date +"%s")
	new_folder="${base}_$agora"
	mkdir "${dir}${new_folder}";pdfseparate "$1" "$new_folder"/pagina_%d.pdf| zenity --progress --pulsate --auto-close --auto-kill --text "Separando páginas de $1 ..."
	shift
done
exit 0