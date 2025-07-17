#!/bin/bash

cd firka

if [ -f "$HOME/.flutter_path" ]; then
  flutter gen-l10n --template-arb-file app_hu.arb
  echo $1 | grep main >/dev/null \
    && flutter build apk --release --tree-shake-icons --split-per-abi --local-engine-src-path $(cat $HOME/.flutter_path)/engine/src --local-engine=android_release --local-engine-host=host_release --target-platform android-arm,android-arm64 \
    || flutter build apk --debug --target-platform android-arm,android-arm64,android-x64
else
    flutter gen-l10n --template-arb-file app_hu.arb
    echo $1 | grep main >/dev/null \
        && flutter build apk --release --tree-shake-icons --split-per-abi --target-platform android-arm,android-arm64 \
        || flutter build apk --debug --target-platform android-arm,android-arm64,android-x64
fi