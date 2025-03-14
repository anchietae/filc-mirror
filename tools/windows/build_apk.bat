@echo off

cd ../../firka
flutter clean
flutter pub get
flutter build apk --release --tree-shake-icons --split-per-abi --target-platform android-arm,android-arm64