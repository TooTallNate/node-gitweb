#!/bin/sh

# This script is used to update the "gitweb.cgi" and "static/"
# files from the 'git' submodule.
cp -v git/gitweb/gitweb.perl gitweb.cgi
cp -rv git/gitweb/static/ .
