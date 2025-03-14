#!/bin/bash

# move out from tools dir
cd ../../firka

# refresh packages
flutter clean
flutter pub get

# check if system is macos
if [[ "$OSTYPE" == "darwin"* ]]; then
  # build ipa
  flutter build ipa --release --tree-shake-icons --no-codesign
else
  echo "Használj macos-t az ipa építéshez."
fi