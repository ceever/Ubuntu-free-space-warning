#!/bin/bash

sleep 30

while [ 1 ]
do
	df | while read row
	do
		set -- `echo $row`
		PC=${@: 5:1}
		SIZE_LIMIT=100001 # k Byte ... smaller than triggers
		PERC_LIMIT=98 # Greater than triggers ... the output of df only delivers absolute/integer numbers anyhow.
		# Change between OR and AND here: ↓↓↓↓
		if [[ $SIZE_LIMIT -gt ${@: 4:1} ]] && [[ $PERC_LIMIT -lt ${PC/\%/} ]]
		then
			notify-send -t 300000 -u critical -i dialog-warning '<h3>Disk space warning!</h3>' "Path '${@: 6:1}' is almost full ($((${@: 4:1}/1000)) MB left, $PC full). Make space or bare the consequences."
		fi
	done
	sleep 600
done