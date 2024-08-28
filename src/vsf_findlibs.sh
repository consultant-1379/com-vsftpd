#!/bin/sh
# Cheesy hacky location of additional link libraries.

locate_library() { [ ! "$1*" = "`echo $1*`" ]; }
find_func() { egrep $1 $2 >/dev/null; }

locate_library /lib64/libpam.so && echo "-lpam";
locate_library /lib/x86_64-linux-gnu/libpam.so && echo "-lpam";

locate_library /lib64/libcap.so && echo "/lib64/libcap.so.2";
locate_library /lib/x86_64-linux-gnu/libcap.so && echo "/lib/x86_64-linux-gnu/libcap.so.2";

# OpenSSL
if find_func SSL_library_init "$1/ssl.o"; then
  echo "-lssl -lcrypto";
elif find_func SSL_new ssl.o; then
  echo "-lssl -lcrypto";
fi

exit 0;

