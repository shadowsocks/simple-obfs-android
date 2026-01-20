# simple-obfs for Android

[simple-obfs](https://github.com/shadowsocks/simple-obfs) plugin for [shadowsocks-android](https://github.com/shadowsocks/shadowsocks-android).

<a href="https://play.google.com/store/apps/details?id=com.github.shadowsocks.plugin.obfs_local"><img src="https://play.google.com/intl/en_us/badges/images/generic/en-play-badge.png" height="48"></a>

## CI STATUS

[![Build Status](https://api.travis-ci.org/shadowsocks/simple-obfs-android.svg)](https://travis-ci.org/shadowsocks/simple-obfs-android)

## REFACTORED PROJECT

This project has been refactored from SBT/Scala to Gradle/Kotlin with CMake for native builds.

### PREREQUISITES

* JDK 11 or higher
* Android SDK
  - Build Tools 34+
  - Android SDK Platform 34
  - Android NDK (included with Android Studio or can be installed via SDK Manager)
  - CMake 3.22.1+ (included with Android Studio or can be installed via SDK Manager)

### BUILD

1. Set environment variable `ANDROID_HOME` to `/path/to/android-sdk`

   For example:
   ```bash
   export ANDROID_HOME=$HOME/Android/Sdk
   ```

2. Initialize git submodules:
   ```bash
   git submodule update --init --recursive
   ```

3. Create `local.properties` file (optional - only needed if signing the release):
   ```properties
   sdk.dir=/path/to/android-sdk
   ```

4. Build the project:

   **Debug build:**
   ```bash
   ./gradlew assembleDebug
   ```

   **Release build:**
   ```bash
   ./gradlew assembleRelease
   ```

   The APK will be generated in `app/build/outputs/apk/`

### DEVELOPMENT

This project now uses:
- **Gradle 8.5** with Kotlin DSL for build configuration
- **Kotlin** for Android app code (converted from Scala)
- **CMake** for native C/C++ code building (converted from Android.mk)
- **Android Gradle Plugin 8.2.0**

#### Project Structure

```
simple-obfs-android/
├── app/
│   ├── build.gradle.kts          # App module build configuration
│   ├── proguard-rules.pro        # ProGuard rules
│   └── src/
│       └── main/
│           ├── AndroidManifest.xml
│           ├── cpp/
│           │   └── CMakeLists.txt # CMake build configuration
│           ├── jni/              # Native C code and dependencies
│           │   ├── simple-obfs/
│           │   ├── libev/
│           │   ├── libancillary/
│           │   └── include/
│           ├── kotlin/           # Kotlin source files
│           │   └── com/github/shadowsocks/plugin/obfs_local/
│           │       ├── BinaryProvider.kt
│           │       ├── ConfigActivity.kt
│           │       └── ConfigFragment.kt
│           └── res/              # Android resources
├── build.gradle.kts              # Root build configuration
├── settings.gradle.kts           # Project settings
├── gradle.properties             # Gradle properties
└── gradlew                       # Gradle wrapper script
```

#### Key Changes from Original

1. **Build System**: Migrated from SBT to Gradle with Kotlin DSL
2. **Language**: Converted Scala code to Kotlin
3. **Native Build**: Replaced Android.mk/ndk-build with CMake
4. **Dependencies**: Updated to use AndroidX and modern libraries
5. **Target SDK**: Updated to Android 14 (API 34)

### TRANSLATE

This plugin is an official plugin thus you can see [shadowsocks-android](https://github.com/shadowsocks/shadowsocks-android/blob/master/README.md#translate)'s instructions to translate this plugin's UI.

## OPEN SOURCE LICENSES

- libancillary: [BSD](https://github.com/shadowsocks/libancillary/blob/shadowsocks-android/COPYING)
- simple-obfs: [GPLv3](https://github.com/shadowsocks/simple-obfs/blob/master/LICENSE)
- libev: [GPLv2](https://github.com/shadowsocks/shadowsocks-libev/blob/master/libev/LICENSE)
- libsodium: [ISC](https://github.com/jedisct1/libsodium/blob/master/LICENSE)
- libudns: [LGPL](https://github.com/shadowsocks/libudns/blob/master/COPYING.LGPL)

## LICENSE

Copyright (C) 2017 by Max Lv <<max.c.lv@gmail.com>>
Copyright (C) 2017 by Mygod Studio <<contact-shadowsocks-android@mygod.be>>

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program. If not, see <http://www.gnu.org/licenses/>.
