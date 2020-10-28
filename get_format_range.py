#/usr/bin/env python3
import sys;
import re;
level = 0
sign = 0
regionstart = 1
linenum = 0
anyifpat = re.compile('^\s*#\s*if[\t dn]')
posifpat = re.compile(r'^\s*#\s*if(?:def\s*__STDC__|\s*defined\(__STDC__\))')
negifpat = re.compile(r'^\s*#\s*if(?:ndef\s*__STDC__|\s*!\s*defined\(__STDC__\))')
elsepat = re.compile('^\s*#\s*else(?:\W|$)')
endifpat = re.compile('^\s*#\s*endif(?:\W|$)')
# elif is not relevant in this code base
for line in sys.stdin:
    linenum += 1
#    print(line, end="")
    if level == 0:
        if posifpat.match(line):
            level,sign = (1,1)
#            print("STARTING", sign)
        if negifpat.match(line):
            level,sign = (1,-1)
#Note that the region is inclusive on both sides, so the #ifndef will be formatted.
            print("--lines",str(regionstart) + ":" + str(linenum))
#            print("STARTING", sign)
    else:
        if level == 1 and elsepat.match(line):
            if sign > 0:
                print("--lines",str(regionstart) + ":" + str(linenum))
            else:
                regionstart = linenum
            sign = -sign
#            print("FLIPPING", sign)
        elif anyifpat.match(line):
            level += 1
#            print("INCREMENTING", level)
        elif endifpat.match(line):
            level -= 1
#            print("DECREMENTING", level)
            if level == 0:
                if sign < 0:
                    regionstart = linenum
#                print("FINISHED")
print("--lines",str(regionstart) + ":" + str(linenum))
