#!/bin/sh

#  PackTexture.sh
#  CocosCubic
#
#  Created by Onur Atamer on 23/07/14.
#  Copyright (c) 2014 Onur Atamer. All rights reserved.


TP="/usr/local/bin/TexturePacker"
cd ${PROJECT_DIR}/${PROJECT}

if [ "${ACTION}" = "clean" ]; then
echo "cleaning..."

rm -f Resources/rounded-sprite*.pvr.ccz
rm -f Resources/background*.plist

rm -f Resources/background*.pvr.ccz
rm -f Resources/background*.plist

# ....
# add all files to be removed in clean phase
# ....
else
#ensure the file exists
if [ -f "${TP}" ]; then
echo "building..."

${TP} --smart-update Resources/CocosCubic-Art/background.tps

${TP} --smart-update Resources/CocosCubic-Art/rounded.tps


exit 0
else
#if here the TexturePacker command line file could not be found
echo "TexturePacker tool not installed in ${TP}"
echo "skipping requested operation."
exit 1
fi

fi
exit 0