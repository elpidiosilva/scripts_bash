#!/bin/bash
##
## Combina os PDFs selecionados em um documento único. Útil para condensar relatórios.
##

## Tratamento do caminho e nome do arquivo
fullpath=$1					# Caminho completo sem aspas, encaminhadas pelo Thunar
filename="${fullpath##*/}"                      # Pega o nome do arquivo, considerando a última / encontrada no caminho
dir="${fullpath:0:${#fullpath} - ${#filename}}" # Subtrai o nome do arquivo do caminho completo
base="${filename%.[^.]*}"                       # Nome do arquivo sem extensão
ext="${filename:${#base} + 1}"                  # Extensão do arquivo
agora=$(date +"%s")
new_filename="agrupado_${agora}.pdf"

gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -sOutputFile="${dir}${new_filename}" "$@" | zenity --progress --pulsate --auto-close --auto-kill --text "Agrupando PDFs ..."

exit 0