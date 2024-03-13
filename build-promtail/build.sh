#!/bin/bash
# set new version
MAJOR_MINOR_VERSION="2.8"
SUB_VERSION='.7'
RELEASE_VERSION="${MAJOR_MINOR_VERSION}${SUB_VERSION}"
UWIT_VERSION='-0uwit3'
LONG_VERSION=${RELEASE_VERSION}${UWIT_VERSION}
DATE=`date -R`
DESCRIPTION="Built for Ubuntu 22.04.1 LTS from promtail github tag ${RELEASE_VERSION}."
RELEASE_NOTE="Updating to ${RELEASE_VERSION} binary. See Grafana changelog for details."
SUB_DIR="promtail-${RELEASE_VERSION}"

# create new build sub dir
cp -a "promtail-0.0.0" $SUB_DIR

# copy new promtail to new dir with short name
cp -p ./promtail-linux-amd64 ./${SUB_DIR}/promtail
# cd to new build sub dir
cd ${SUB_DIR}

# update the debian packaging files for new build
# ./debian/promtail/DEBIAN/control # LONG_VERSION, DESCRIPTION
sed -i "s/LONG_VERSION/${LONG_VERSION}/g" ./debian/promtail/DEBIAN/control 
#./debian/control # LONG_VERSION, DESCRIPTION
sed -i "s/LONG_VERSION/${LONG_VERSION}/g" ./debian/control
sed -i "s/DESCRIPTION/${DESCRIPTION}/g" ./debian/control
#./debian/changelog # LONG_VERSION, RELEASE_NOTE, DATE
sed -i "s/LONG_VERSION/${LONG_VERSION}/g" ./debian/changelog
sed -i "s/RELEASE_NOTE/${RELEASE_NOTE}/g" ./debian/changelog
sed -i "s/DATE/${DATE}/g" ./debian/changelog
#./debian/files # LONG_VERSION
sed -i "s/LONG_VERSION/${LONG_VERSION}/g" ./debian/files

# change date on all build files
find . -exec touch {} \;

# return to parent build dir
cd ..

# delete existing tar file if necessary
#echo "promtail_${RELEASE_VERSION}"
#ls -ltd "promtail_${RELEASE_VERSION}*"
# rm -rf "promtail*${RELEASE_VERSION}*"

# create the orig tar gz
tar cvzf promtail_${RELEASE_VERSION}.orig.tar.gz promtail-${RELEASE_VERSION}

# return to sub build dir
cd ${SUB_DIR}

# build .deb
debuild -us -uc 2>&1 | tee ../debuild.out


# return to parent build dir
cd ..

# check to see if the .deb file was built
ls -ltd promtail_${LONG_VERSION}_amd64.deb



