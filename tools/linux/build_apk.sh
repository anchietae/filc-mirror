#!/usr/bin/env bash

cd firka

rm $HOME/.flutter-devtools/apk-code-size-analysis_*.json 2>/dev/null || true
flutter gen-l10n --template-arb-file app_hu.arb
echo $1 | grep main >/dev/null \
	&& flutter build apk --flavor production --release --tree-shake-icons --split-per-abi --target-platform android-arm,android-arm64 \
	|| flutter build apk --flavor staging --release --tree-shake-icons --split-per-abi --target-platform android-arm64 --analyze-size

cp $HOME/.flutter-devtools/apk-code-size-analysis_*.json build/ || true
