if gcc conLoad.c -o conLoad
then
	if gcc -o input input.c
	then
		./conLoad ./input
		
	fi
fi