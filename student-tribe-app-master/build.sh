#!/bin/bash

# Updating pubspec.yaml version
set -e
if [ -z "$2" ]
then
  perl -i -pe 's/^(version:\s+\d+\.\d+\.\d+\+)(\d+)$/$1.($2+1)/e' pubspec.yaml
else
  sed -i '' "s/^version.*/version: $2/g" pubspec.yaml
fi

# Perform flutter clean
flutter clean

# Build Android Apk if the argument is apk
if [ "$1" == "apk" ]
then
  flutter build apk
  cd build/app/outputs/flutter-apk/
  open .
else
  flutter build appbundle
fi

# Build iOS if the argument is ios
if [ "$1" == "all" ]
then
  flutter build ios
  cd ios
  open Runner.xcworkspace
fi