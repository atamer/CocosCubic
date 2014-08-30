#!/bin/sh

#  PackTexture.sh
#  CocosCubic
#
#  Created by Onur Atamer on 23/07/14.
#  Copyright (c) 2014 Onur Atamer. All rights reserved.

exit 0

TP="/usr/local/bin/TexturePacker"
cd ${PROJECT_DIR}/${PROJECT}

if [ "${ACTION}" = "clean" ]; then
echo "cleaning..."

rm -f Resources/*.pvr.ccz
rm -f Resources/colors*.plist
rm -f Resources/buttons*.plist
rm -f Resources/grid*.plist


# ....
# add all files to be removed in clean phase
# ....
else
#ensure the file exists
if [ -f "${TP}" ]; then
echo "building..."

${TP} --smart-update --multipack Resources/CocosCubic-Art/buttons/buttons.tps

${TP} --smart-update --multipack Resources/CocosCubic-Art/grid_3_4/grid_3_4.tps

${TP} --smart-update --multipack Resources/CocosCubic-Art/grid_5_6/grid_5_6.tps

${TP} --smart-update --multipack Resources/CocosCubic-Art/colors/colors.tps

exit 0
else
#if here the TexturePacker command line file could not be found
echo "TexturePacker tool not installed in ${TP}"
echo "skipping requested operation."
exit 1
fi

fi
exit 0