#!/bin/sh

if [ ! -e "$1" ]; then
    echo "Library not provided"
    exit 1
fi

lib=$1

count=`nm $lib | \grep "U " | \grep -v -c "GLIB\|CXXABI\|GCC\|Py\|Qt\|GFORTRAN"`

echo "$1 has Undefined Symbols: $count"
if [ ${count} -gt 0 ]; then
    echo "`nm $lib | \grep "U " | \grep -v "GLIB\|CXXABI\|GCC\|Py\|Qt\|GFORTRAN"`"
fi

echo "Check for GCC versions:"
echo "`nm $lib | \grep "U " | \grep "GCC_" | awk -F @ '{print "\t"$3}' | sort -u -V`"
echo "Check for CXXABI versions:"
echo "`nm $lib | \grep "U " | \grep "CXXABI_" | awk -F @ '{print "\t"$3}' | sort -u -V`"
echo "Check for GLIBC versions:"
echo "`nm $lib | \grep "U " | \grep "GLIBC_" | awk -F @ '{print "\t"$3}' | sort -u -V`"
echo "Check for GLIBCXX versions:"
echo "`nm $lib | \grep "U " | \grep "GLIBCXX_" | awk -F @ '{print "\t"$3}' | sort -u -V`"
