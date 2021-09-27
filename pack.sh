#!/bin/sh

if [ ! -d ./internal ]; then
    echo "Please run under the correct directory!"
    exit 1
fi

tmpdir=__tmp__
workdir=live_injection_7ed136ec_7a61_4b54_adc3_ae494d5106ea

[ -d ./$tmpdir ] && rm -rf ./$tmpdir
[ -f ./live_injection.tar.gz ] && rm -f ./live_injection.tar.gz

mkdir -p ./$tmpdir/$workdir

echo "packing sysroot ..."
tar czf $tmpdir/$workdir/sysroot.tar.gz sysroot

cd ./$tmpdir

cp -a ../internal/distro  ./$workdir/
cp -a ../internal/hook.sh ./$workdir/
dos2unix -q ./$workdir/hook.sh

echo "packing live_injection ..."
tar czf ../live_injection.tar.gz $workdir

cd ..

rm -rf ./$tmpdir

if [ -f ./live_injection.tar.gz ]; then
    echo -e "\n\n========== SUCCESS ============\n\n"
else
    echo -e "\n\n========== FAILED ============\n\n"
fi
