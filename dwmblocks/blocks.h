//Modify this file to change what commands output to your statusbar, and recompile using the make command.
static const Block blocks[] = {
	/*Icon*/	/*Command*/		/*Update Interval*/	/*Update Signal*/
	{"Who:", "whoami", 60 * 60, 1},
	{"Vol:", "printf \"%s%%\" \"$(pulsemixer --id 'sink-1' --get-volume | cut -d' ' -f 1)\"", 1, 5},
	{"D:", "df -h /dev/sda6 | awk ' /[0-9]/ {print $3 \"/\" $2}'", 60, 4},
	{"M:", "free -h | awk '/^Mem/ { print $3\"/\"$2 }' | sed s/i//g",	30,		0},

	{"T:", "date +'%a %b%e, %G | %I:%M:%S%p'", 1, 10},
};

//sets delimeter between status commands. NULL character ('\0') means no delimeter.
static char delim[] = " | ";
static unsigned int delimLen = 5;
