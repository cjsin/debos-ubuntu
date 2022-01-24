#!/bin/bash
set -e
set -vx


#
#For some reason, 'adduser' hangs reading this libcom_err.so file, every time!
#
# So we do nothing here for now
exit 0

#2022/01/24 17:03:20 setup-user | [pid    24] close(5)                    = 0
#2022/01/24 17:03:20 setup-user | [pid    24] openat(AT_FDCWD, "/lib/x86_64-linux-gnu/libcom_err.so.2", O_RDONLY|O_CLOEXEC) = 5
#2022/01/24 17:03:20 setup-user | [pid    24] read(5, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0


echo "I: create testuser" 1>&2
strace -fF adduser --gecos "Test User" testuser

echo "I: set testuser password" 1>&2
echo "testuser:password" | chpasswd
usermod -a -G sudo testuser
echo "Completed ${0##*/}" 1>&2
