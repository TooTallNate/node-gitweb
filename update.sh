#!/bin/sh

# This script is used to update the "gitweb.cgi" and "static/"
# files from the 'git' submodule.
cp -v git/gitweb/gitweb.perl gitweb.cgi
cp -rv git/gitweb/static/ .

# TODO: Use 'curl' to get the files directly from the main Git repo.
# curl "http://git.kernel.org/?p=git/git.git;a=blob_plain;f=gitweb/gitweb.perl;hb=HEAD" > gitweb.cgi
