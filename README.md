# ZTools 7/4 1/25/2021

##Tools:

    check - checks story file integrity, same as $verify command. Works on all
	    types except for V1, V2 and early V3 games which have no checksum
	    in the header. Optionally outputs a new story file of the correct
	    length.

	usage: check story-file-name [new-story-file-name]

    infodump - dumps header, object list, grammar and dictionary of a given
	       story file. Works on all types. Grammar doesn't work for V6
	       games yet.

	usage: infodump [options...] story-file-name

    inforead - converts IBM bootable disks to story files. Only for IBM PCs,
	       requires Microsoft C, Borland C, or DJGPP. Optional
               parameters are the start track (defaults to 6) and the
               drive number (0 for A: or 1 for B:).

	usage: inforead story-file-name [start-track [drive#]]

    pix2gif - converts IBM MG1/EG1/EG2 picture files from V6 games to
	      individual GIF files, viewable on most platforms.

	usage: pix2gif picture-file-name

    txd - disassembles story files to Z-code assembly language, plus text
	  strings. Works on all games from V1 to V8. Also supports Inform
	  assembler syntax.

	usage: txd [options...] story-file-name

## Changes for 7/4

* Better support for story files compiled with Jesse McGrew's ZAPF.

* txd now prints the verb associated with an an action table entry.

* txd now knows all types in a JE instruction are the same.

* Support for pre-ANSI C compilers is discontinued, but not yet removed.

* Code has been auto-formatted.

* See readme.1st for the 7/3 changes.
