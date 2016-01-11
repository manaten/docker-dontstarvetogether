#!/usr/bin/env bash

clean() {
  rm -f $file1 $file2
}
trap clean EXIT

file1=`mktemp`
file2=`mktemp`

# dst-server
cat > $file1 <<- EOF
usage: dst-server [--help] <command> [<args>]

The commands are:
   start    Start the server
   update   Run game and mod updates
   log      Show a log

See 'dst-server help <command>' to read about a specific command.
EOF
../build/script/dst-server > $file2 && exit 1
cmp $file1 $file2 || exit 1
../build/script/dst-server help > $file2 || exit 1
cmp $file1 $file2 || exit 1
../build/script/dst-server --help > $file2 || exit 1
cmp $file1 $file2 || exit 1

../build/script/dst-server --foo 2> $file2 && exit 1
cmp $file1 $file2 || exit 1
../build/script/dst-server foo 2> $file2 && exit 1
cmp $file1 $file2 || exit 1

# dst-server start
cat > $file1 <<- EOF
usage: dst-server start [--update=all|none|game|mods]

   --update=all
      Update the game and the mods before launch the server.
   --update=none
      Update nothing, just start the server.
   --update=game
      Update just the game (no the mods) and lauch the server.
   --update=mods
      Update the mods and launch the server. This is the default behaviour.
EOF
../build/script/dst-server help start > $file2 || exit 1
cmp $file1 $file2 || exit 1
../build/script/dst-server --help start > $file2 || exit 1
cmp $file1 $file2 || exit 1
../build/script/dst-server start --help > $file2 || exit 1
cmp $file1 $file2 || exit 1
../build/script/dst-server start --help foo > $file2 || exit 1
cmp $file1 $file2 || exit 1

# dst-server update
cat > $file1 <<- EOF
usage: dst-server update [--all|--game|--mods]
EOF
../build/script/dst-server help update > $file2 || exit 1
cmp $file1 $file2 || exit 1
../build/script/dst-server --help update > $file2 || exit 1
cmp $file1 $file2 || exit 1
../build/script/dst-server update --help > $file2 || exit 1
cmp $file1 $file2 || exit 1
../build/script/dst-server update --help foo > $file2 || exit 1
cmp $file1 $file2 || exit 1

# dst-server log
cat > $file1 <<- EOF
usage: dst-server log [--server|--chat]
EOF
../build/script/dst-server help log > $file2 || exit 1
cmp $file1 $file2 || exit 1
../build/script/dst-server --help log > $file2 || exit 1
cmp $file1 $file2 || exit 1
../build/script/dst-server log --help > $file2 || exit 1
cmp $file1 $file2 || exit 1
../build/script/dst-server log --help foo > $file2 || exit 1
cmp $file1 $file2 || exit 1
