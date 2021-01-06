#!/bin/bash

while [ 1 ]
do
	df | while read row
	do
		set -- `echo $row`
		PC=${@: 5:1}
		if [[ 100000 -gt ${@: 4:1} ]] && [[ 98 -lt ${PC/\%/} ]]
		then
			notify-send -t 300000 -u critical -i dialog-warning '<h3>Disk space warning!</h3>' "Path '${@: 6:1}' is almost full ($((${@: 4:1}/1000)) MB left, $PC full). Make space or bare the consequences."
		fi
	done
	sleep 600
done