if [ -z ${1+x} ]; then
  echo "pass destination dir path"
  exit 0
fi

if [ -d $1 ]; then
  mv *.pdf "$1"
  mv *.epub "$1"
  mv *.mobi "$1"
  mv *.azw3 "$1"
  mv *.PDF "$1"
else
  echo "dir $1 does't exist"
fi
