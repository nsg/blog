#!/bin/bash

# Quick hack by Stefan Berggren (nsg.cc), Mars 2009

if [ "x$1" = "x" ]; then
  echo "Usage: $0 [stable|beta|check]";
fi

function kill_firefox {
  echo -n "Warning, all Firefox windows will be closed, press enter to start "
  read
  killall firefox-bin &> /dev/null
  killall firefox &> /dev/null
}

if [ "x$1" = "xcheck" ]; then

  echo "Checking files"

  if [ -L "$HOME/.mozilla" ]; then
    echo "  $HOME/.mozilla OK"
  else
    echo "  Error, $HOME/.mozilla should be a symlink"
  fi

  if [ -d "$HOME/.mozilla-beta" ]; then
    echo "  $HOME/.mozilla-beta OK"
  else
    echo "  Error, $HOME/.mozilla-beta not found"
  fi

  if [ -d "$HOME/.mozilla-stable" ]; then
    echo "  $HOME/.mozilla-stable OK"
  else
    echo "  Error, $HOME/.mozilla-stable not found"
  fi

  if [ -d "/opt/firefox" ]; then
    echo "  /opt/firefox OK"
  else
    echo "  Error, /opt/firefox not found"
  fi
  
  echo ""
  echo "Checking links"
  
  LNK=`ls -l $HOME/.mozilla | awk -F ' ' '{print $10}'`
  if [ "x$LNK" = "x$HOME/.mozilla-beta" ]; then
    echo "  .mozilla points to beta"
  else
    echo "  .mozilla points to stable"
  fi

  LNK=`ls -l /usr/bin/firefox | awk -F ' ' '{print $10}'`
  if [ "x$LNK" = "x/opt/firefox/firefox" ]; then
    echo "  /usr/bin/firefox points to beta"
  else
    echo "  /usr/bin/firefox points to stable"
  fi

fi

if [ "x$1" = "xstable" ]; then
  kill_firefox
  unlink $HOME/.mozilla
  ln -s $HOME/.mozilla-stable $HOME/.mozilla
  sudo rm /usr/bin/firefox
  sudo dpkg-divert --rename --remove /usr/bin/firefox
  echo "Firefox restored to stable"
fi

if [ "x$1" = "xbeta" ]; then
  kill_firefox
  unlink $HOME/.mozilla
  ln -s $HOME/.mozilla-beta $HOME/.mozilla
  sudo dpkg-divert --divert /usr/bin/firefox.ubuntu --rename /usr/bin/firefox
  sudo ln -s /opt/firefox/firefox /usr/bin/firefox
  echo "Firefox restored to beta"
fi


