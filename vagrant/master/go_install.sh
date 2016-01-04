#!/bin/bash

set -e

GOVERSION="1.5.2"
GOTARBALL="go${GOVERSION}.linux-amd64.tar.gz"
export GOROOT=/usr/local/go
export GOPATH=/opt/go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
if [ ! $(which go) ]; then
    echo "Installing Go $GOVERSION"
    echo " Downloading $GOTARBALL"
    wget --quiet --directory-prefix=/tmp https://storage.googleapis.com/golang/$GOTARBALL
    echo " Extracting $GOTARBALL to $GOROOT"
    tar -C /usr/local -xzf /tmp/$GOTARBALL
    echo " Configuring GOPATH"
    mkdir -p $GOPATH/src $GOPATH/bin $GOPATH/pkg
    chown -R vagrant $GOPATH
    echo " Configuring env vars"
    echo "export PATH=\$PATH:$GOROOT/bin:$GOPATH/bin" | tee /etc/profile.d/golang.sh > /dev/null
    echo "export GOROOT=$GOROOT" | tee --append /etc/profile.d/golang.sh > /dev/null
    echo "export GOPATH=$GOPATH" | tee --append /etc/profile.d/golang.sh > /dev/null
else
    echo "Found $(go version)"
fi

