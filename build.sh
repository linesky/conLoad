if gcc conLoad.c -o conLoad
then
	if as -o input.o input.S
	#if gcc -o input input.c
	then
		if ld -o input input.o
		then
			./conLoad ./input
		fi
	fi
fi