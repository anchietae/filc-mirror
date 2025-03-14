#!/bin/bash

# move out from tools dir
cd ../../firka || exit

# refresh packages
flutter clean
flutter pub get

# build apk
flutter build apk --release --tree-shake-icons --split-per-abi --target-platform android-arm,android-arm64