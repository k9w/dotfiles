#!/bin/ksh

# This is the original unmodified script posted by Crystal Kolipe.
# https://marc.info/?l=openbsd-misc&m=175225722717854

if [ "$1" == "i" ] ; then touch checksums ; fi
for i in `find . -name checksums` ;
do (
if [ "$1" == "a" ] ; then echo -n "Not v" ; else echo -n "V" ; fi
echo "erifying checksums in directory ${i%/checksums}";
cd ${i%/checksums};
if [ "$1" != "a" ] ; then sha512 -cq checksums; fi
let flag=0;
for j in !(checksums|checksums.bak) ;
do
if [ ! -d "$j" ] ; then grep -F "($j)" checksums > /dev/null || { if [ -z "$1" ] ; then echo "$j is not in the checksums file!" ; let flag=1 ; else echo "Adding $j to checksums file" ; sha512 "$j" >> checksums ; fi ; } fi ;
done ;
if [ $flag -eq 1 ] ; then echo "Run $0 with any command line arguments to add missing entries to the checksums file."; else echo "All files have entries in the checksum file."; fi ;
 );
done
if [ "$1" == "i" -a ! -s checksums ] ; then rm -f checksums ; fi

