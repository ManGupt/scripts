#!/bin/sh

if [ ! -e "$1" ]; then
    echo "Library not provided"
    exit 1
fi

lib=$1
bin="nm"
grp="U "
if ! [ -z "$2" ]; then
    echo "Using readelf:"
    bin="readelf -a -W"
    grp="UND "
else
    echo "Using nm:"
fi

count=`$bin $lib | \grep "$grp" | \grep -v "__gmon_start__\|registerTMCloneTable\|GLIB\|CXXABI\|GCC\|Py\|Qt\|GFORTRAN" | awk -F "$grp" '{print "    U "$2}' | sort -u | wc -l`

echo "  $1 has Undefined Symbols: $count"
if [ ${count} -gt 0 ]; then
    echo "`$bin $lib | \grep "$grp" | \grep -v "__gmon_start__\|registerTMCloneTable\|GLIB\|CXXABI\|GCC\|Py\|Qt\|GFORTRAN" | awk -F "$grp" '{print "    U "$2}' | sort -u`"
fi

echo "Check for GCC versions:"
echo "`$bin $lib | \grep "$grp" | \grep "@@GCC_" | awk -F "@@" '{print "    "$2}' | sort -u -V`"
echo "Check for CXXABI versions:"
echo "`$bin $lib | \grep "$grp" | \grep "@@CXXABI_" | awk -F "@@" '{print "    "$2}' | sort -u -V`"
echo "Check for GLIBC versions:"
echo "`$bin $lib | \grep "$grp" | \grep "@@GLIBC_" | awk -F "@@" '{print "    "$2}' | sort -u -V`"
echo "Check for GLIBCXX versions:"
echo "`$bin $lib | \grep "$grp" | \grep "@@GLIBCXX_" | awk -F "@@" '{print "    "$2}' | sort -u -V`"
