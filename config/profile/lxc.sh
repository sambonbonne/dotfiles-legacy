export PATH="$PATH:/usr/local/bin:/usr/bin:/bin"

if [ `id -u` -eq 0 ]; then
  export USER=root
  export PATH="$PATH:/usr/local/sbin:/usr/sbin:/sbin"
fi
