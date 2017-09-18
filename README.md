# cookie-monster gentoo overlay [![Build Status](https://travis-ci.org/g0dsCookie/cookie-monster.svg?branch=master)](https://travis-ci.org/g0dsCookie/cookie-monster)

Gentoo overlay with ebuilds which were either missing or outdated in other repositories.

# Using with a recent portage version

Create a new config file under /etc/portage/repos.conf/cookie-monster.conf with the following contents:

    [cookie-monster]
    auto-sync = yes
    location = /usr/local/portage
    sync-type = git
    sync-uri = https://github.com/g0dsCookie/cookie-monster.git

# Using with layman

You will need a layman build with git activated:

    USE=git emerge -av layman

Add this overlay:

    layman -o https://raw.githubusercontent.com/g0dsCookie/cookie-monster/master/layman.xml -f -a cookie-monster

