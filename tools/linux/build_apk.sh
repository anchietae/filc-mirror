#!/usr/bin/env bash

cd firka

flutter gen-l10n --template-arb-file app_hu.arb
git branch | grep '*' | grep dev >/dev/null \
	&& flutter build apk --debug --target-platform android-arm,android-arm64,android-x64 \
	|| flutter build apk --release --tree-shake-icons --split-per-abi --target-platform android-arm,android-arm64
