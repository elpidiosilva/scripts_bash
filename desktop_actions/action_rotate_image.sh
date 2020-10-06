## Linha de comando: /usr/local/bin/action_rotate_image.sh %F

#!/bin/bash
OPCAO=$(zenity  --list  --text "Rotacionar..." --radiolist  --column " " --column "Opção" TRUE "Direita 90" FALSE 'Esquerda 90' FALSE "Direita 180" FALSE 'Esquerda 180')

case "$OPCAO" in
	"Direita 90")
		ROTACAO="90"
	;;
	"Esquerda 90")
		ROTACAO="-90"
	;;
	"Direita 180")
		ROTACAO="180"
	;;
	"Esquerda 180")
		ROTACAO="-180"
	;;
esac
		
while (( "$#" )); do  
	## Tratamento do caminho e nome do arquivo
	#echo $@|zenity --text-info			# Debug
	#echo $1|zenity --text-info			# Debug
	convert "$1" -rotate "$ROTACAO" -quality 100 "$1" | zenity --progress --pulsate --auto-close --auto-kill --text "Rotacionando $1 ..."
	shift
done

exit 0
