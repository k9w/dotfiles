#!/bin/ksh

# From Crystal Kolipe
# https://marc.info/?l=openbsd-misc&m=175225722717854

# If the first argument is "i", create an empty checksums file
if [ "$1" == "i" ]; then
    touch checksums
fi

# Loop through all files named "checksums" found in the current
# directory and subdirectories
for i in `find . -name checksums`; do
    (
        # Print verification status based on the first argument
        if [ "$1" == "a" ]; then
            echo -n "Not v"
        else
            echo -n "V"
        fi

        echo "erifying checksums in directory ${i%/checksums}"

        # Change to the directory containing the checksums file
        cd "${i%/checksums}"

        # If not in "add" mode, verify checksums using sha512
        if [ "$1" != "a" ]; then
            sha512 -cq checksums
        fi

        # Initialize a flag to track missing entries
        let flag=0

        # Loop through all files except checksums and checksums.bak
        for j in !(checksums|checksums.bak); do
            # If the item is a file (not a directory)
            if [ ! -d "$j" ]; then
                # Check if the file is listed in the checksums file
                grep -F "($j)" checksums > /dev/null || {
                    if [ -z "$1" ]; then
                        # If no argument is given, warn about missing
                        # entry
                        echo "$j is not in the checksums file!"
                        let flag=1
                    else
                        # If any argument is given, add the file to
                        # checksums
                        echo "Adding $j to checksums file"
                        sha512 "$j" >> checksums
                    fi
                }
            fi
        done

        # Report whether all files are accounted for
        if [ $flag -eq 1 ]; then
            echo "Run $0 with any command line arguments to add missing"
            echo "entries to the checksums file."
        else
            echo "All files have entries in the checksum file."
        fi
    )
done

# If "i" mode was used and the checksums file is still empty, remove it
if [ "$1" == "i" -a ! -s checksums ]; then
    rm -f checksums
fi


if false; then

NAME
    verify_checksums.sh - verify or initialize SHA-512 checksums for files

SYNOPSIS
    verify_checksums.sh [MODE]

DESCRIPTION
    This script recursively locates all files named 'checksums' in the current
    directory tree and verifies or updates their contents using SHA-512 hashes.

    It supports three modes of operation:

    i   Initialize mode. Creates a 'checksums' file in the current directory.
        If no files are added, the file is deleted at the end.

    a   Add mode. Adds missing files to each 'checksums' file using SHA-512
        hashes. Does not perform verification.

    (no argument)
        Verification mode. Verifies each file listed in the 'checksums' file
        using SHA-512. Warns about any missing entries.

BEHAVIOR
    - For each 'checksums' file found:
        • Changes into its parent directory.
        • If in verification mode, runs `sha512 -cq checksums`.
        • Iterates over all files except 'checksums' and 'checksums.bak'.
        • If a file is not listed in 'checksums':
            - In verification mode, prints a warning.
            - In add mode, appends its SHA-512 hash to 'checksums'.

    - At the end of each directory scan:
        • Reports whether all files are accounted for.
        • Suggests rerunning in add mode if entries are missing.

    - In initialize mode:
        • Creates a 'checksums' file.
        • Deletes it if no entries are added.

REQUIREMENTS
    - sha512 command must be available in PATH.
    - Shell must support extended globbing (e.g., Bash with `shopt -s extglob`).

EXAMPLES
    Initialize a new checksums file:
        ./verify_checksums.sh i

    Add missing entries to all checksums files:
        ./verify_checksums.sh a

    Verify all checksums and report missing entries:
        ./verify_checksums.sh

AUTHOR
    Written by [Your Name Here]

COPYRIGHT
    This is free software; you may redistribute it under the terms of the MIT
    License. See the LICENSE file for details.

Incompatible with OpenBSD sh

OpenBSD's sh is a strict POSIX shell and does not support:

    Extended globbing:
    sh
for j in !(checksums|checksums.bak)

This syntax is Bash/ksh-specific. POSIX sh does not support !(pattern).

== string comparison:
sh
if [ "$1" == "i" ]

POSIX sh uses = for string comparison. == is a Bash/ksh extension.

let arithmetic:
sh
    let flag=0

    POSIX sh uses flag=0 and flag=$((flag + 1)) for arithmetic. let is not available.

    Subshell grouping with (...) inside for loop: While POSIX sh supports subshells, the way it's used here may behave differently depending on the shell.

 Compatible with ksh or bash

This script is compatible with:

    KornShell (ksh) — especially on OpenBSD, which includes ksh as /bin/ksh.

    Bash — if installed separately.

 How to run it on OpenBSD

To run this script successfully on OpenBSD, use:
sh

fi
