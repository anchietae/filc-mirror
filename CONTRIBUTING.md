# Flutter

A Firka a NixOS legfirssebb stabil flutter packagét használja (ami jelenleg Flutter `3.29.3` és
Dart `3.7.2`). A projekt tartalmaz egy flake.nix file-t ami tartalmaz egy dev shell-t ezt a 
`nix develop` parancsal lehet aktiválni (a nix flake nem tartalmazza az android studio-t).

# Keystore

[Secrets dokumentáció](secrets/README.md)

# Build

## dev
A dev buildhez nem közelező keystore használata
```shell
$ cd firka
$ flutter build apk --flavor staging --debug --target-platform android-arm,android-arm64,android-x64
```

## staging
**Keystore használata kötelező**
```shell
$ cd firka
$ flutter build apk --flavor staging --release --tree-shake-icons --split-per-abi --target-platform android-arm64
```

## release
**Keystore használata kötelező**
```shell
$ cd firka
$ flutter build apk --flavor production --release --tree-shake-icons --split-per-abi --target-platform android-arm,android-arm64
```