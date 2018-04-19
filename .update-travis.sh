#!/bin/bash
TRAVISYML="$(dirname $0)/.travis.yml"

wget -qO \
	"${TRAVISYML}.new" \
	"https://raw.githubusercontent.com/mrueg/repoman-travis/master/.travis.yml"
mv -i "${TRAVISYML}.new" "${TRAVISYML}" || rm -f "${TRAVISYML}.new"

