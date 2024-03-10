#!/bin/sh

echo ${DESKTOP_SESSION}
if [ ${DESKTOP_SESSION} = 'awesome' ] && [ -f ~/.xmodmap ] ; then
    xmodmap ~/.xmodmap
fi
