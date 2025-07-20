# Flutter telepítése

A flutter telepítéséhez a dokumentáció [itt](https://docs.flutter.dev/get-started/install) található.

# Keystore

[Secrets dokumentáció](secrets/README.md)

# Android debug build

A dev buildhez nem közelező keystore használata
```shell
$ cd firka
$ flutter build apk --debug --target-platform android-arm,android-arm64,android-x64
```

# Android release build

A release buildhez közelező egy keystore használata, illetve a saját flutter forkunk használata.

## Custom flutter engine setupolása

```shell
$ git clone https://git.firka.app/firka/flutter
$ cd flutter
$ . dev/tools/envsetup.sh
$ gclient sync -D
$ ./dev/tools/build_release.sh
```

## Release apk buildelése

```shell
$ ./tools/linux/build_apk.sh
```