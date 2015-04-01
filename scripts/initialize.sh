#!/bin/bash

set -e

echo "=> Begin Initialize Script"

echo "=> Export NVM path"
export NVM_DIR="/usr/local/nvm"

echo "=> Load NVM"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

echo "=> Enter Mobile project directory"
cd /code/mobilefe

echo "=> Run Grunt (this may take a while...)"
grunt server
