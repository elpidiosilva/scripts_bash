
#!/bin/bash
DST_FORMAT=$(zenity  --list  --width 420 --height 340 --text "Converter documento para ..." --radiolist  --column " " --column "Formato" --column "Descrição" TRUE "pdf"	"(Leitura Multiplataforma)" FALSE "odt"	"(Texto LibreOffice)" FALSE "ods" "(Planilha LibreOffice)" FALSE "odp" "(Apresentação LibreOffice)" FALSE "doc" "(Texto Microsoft Office)" FALSE "docx" "(Texto Microsoft Office 2003+)" FALSE "xls" "(Planilha Microsoft Office)"  FALSE "xlsx" "(Planilha Microsoft Office 2003+)"  FALSE "ppt" "(Apresentação Microsoft Office)"  FALSE "pptx" "(Apresentação Microsoft Office 2003+)")
zenity --warning --text "Feche todas as janelas e documentos do LibreOffice antes de continuar.\n\n\nAVISO: Não é possível converter entre tipos de documento distintos\n(Ex: Planilha -> Apresentação)"
killall -9 soffice.bin

while (( "$#" )); do  
	## Tratamento do caminho e nome do arquivo
	fullpath=$1					# Caminho completo sem aspas, encaminhadas pelo Thunar
	filename="${fullpath##*/}"                      # Pega o nome do arquivo, considerando a última / encontrada no caminho
	dir="${fullpath:0:${#fullpath} - ${#filename}}" # Subtrai o nome do arquivo do caminho completo
	base="${filename%.[^.]*}"                       # Nome do arquivo sem extensão
	ext="${filename:${#base} + 1}"                  # Extensão do arquivo

	libreoffice --headless --invisible --convert-to "$DST_FORMAT" --outdir "$dir" "$1"| zenity --progress --pulsate --auto-close --auto-kill --text "Convertendo $base.$ext para $DST_FORMAT ..."
	shift
done

exit 0