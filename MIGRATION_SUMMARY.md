# Project Refactoring Summary

## Overview
This document summarizes the refactoring of simple-obfs-android from SBT/Scala to Gradle/Kotlin with CMake.

## Changes Made

### 1. Build System Migration: SBT → Gradle

#### Created Files:
- `build.gradle.kts` - Root project build configuration
- `settings.gradle.kts` - Project settings and module inclusion
- `gradle.properties` - Gradle build properties
- `app/build.gradle.kts` - App module build configuration
- `app/proguard-rules.pro` - ProGuard configuration for release builds
- `gradlew` - Gradle wrapper script (executable)
- `gradle/wrapper/gradle-wrapper.properties` - Gradle wrapper properties

#### Key Configuration:
- Gradle 8.5 with Kotlin DSL
- Android Gradle Plugin 8.2.0
- Kotlin Plugin 1.9.20
- Target SDK: 34 (Android 14)
- Min SDK: 19 (Android 4.4)
- Build Tools: Modern AndroidX libraries

#### Removed Files (obsolete):
- `build.sbt` - Old SBT build file (can be deleted)
- `project/build.properties` - Old SBT properties (can be deleted)
- `project/plugins.sbt` - Old SBT plugins (can be deleted)

### 2. Native Build Migration: Android.mk → CMake

#### Created Files:
- `app/src/main/cpp/CMakeLists.txt` - CMake build configuration for native code

#### Key Changes:
- Replaced `ndk-build` with CMake 3.22.1+
- Builds same native libraries:
  - `libcork` (static)
  - `libev` (static)
  - `libancillary` (static)
  - `libobfs-local.so` (shared executable)
- Maintains all compiler flags and definitions
- Support for armeabi-v7a, arm64-v8a, x86, x86_64

#### Preserved Files:
- `app/src/main/jni/*` - All native source code (kept in same location)
  - `simple-obfs/` - Main obfuscation implementation
  - `libev/` - Event loop library
  - `libancillary/` - File descriptor passing
  - `include/` - Header files

### 3. Language Migration: Scala → Kotlin

#### Converted Files:

| Original (Scala) | New (Kotlin) | Location |
|-----------------|--------------|----------|
| `BinaryProvider.scala` | `BinaryProvider.kt` | `app/src/main/kotlin/com/github/shadowsocks/plugin/obfs_local/` |
| `ConfigFragment.scala` | `ConfigFragment.kt` | `app/src/main/kotlin/com/github/shadowsocks/plugin/obfs_local/` |
| `ConfigActivity.scala` | `ConfigActivity.kt` | `app/src/main/kotlin/com/github/shadowsocks/plugin/obfs_local/` |

#### Key Conversions:
- `PreferenceFragment` → `PreferenceFragmentCompat` (AndroidX)
- Scala collections → Kotlin collections
- Scala lambda syntax → Kotlin lambda syntax
- Scala pattern matching → Kotlin when expressions
- Added null safety with Kotlin's type system

#### Old Files (can be deleted):
- `src/main/scala/com/github/shadowsocks/plugin/obfs_local/*.scala`

### 4. Resource Migration

#### Moved Files:
- `src/main/res/*` → `app/src/main/res/*`
- `src/main/AndroidManifest.xml` → `app/src/main/AndroidManifest.xml`

#### Added Files:
- `app/src/main/res/layout/toolbar_light_dark.xml` - Toolbar layout
- `app/src/main/res/values/themes.xml` - App theme definition

#### Updated Files:
- `app/src/main/res/values/strings.xml` - Added missing strings
- `app/src/main/AndroidManifest.xml` - Added theme attribute

### 5. Dependencies Update

#### Old (SBT):
```scala
libraryDependencies += "com.github.shadowsocks" %% "plugin" % "0.0.2"
```

#### New (Gradle):
```kotlin
implementation("androidx.appcompat:appcompat:1.6.1")
implementation("androidx.preference:preference-ktx:1.2.1")
implementation("com.github.shadowsocks:plugin:0.0.2")
```

### 6. Documentation Updates

- `README.md` - Completely rewritten with Gradle/Kotlin build instructions
- `README_OLD.md` - Backup of original README (can be deleted after verification)
- `.gitignore` - Updated for Gradle/CMake build artifacts

## New Project Structure

```
simple-obfs-android/
├── app/
│   ├── build.gradle.kts              # App module configuration
│   ├── proguard-rules.pro            # ProGuard rules
│   └── src/main/
│       ├── AndroidManifest.xml       # App manifest
│       ├── cpp/
│       │   └── CMakeLists.txt        # CMake configuration
│       ├── jni/                      # Native code (unchanged)
│       │   ├── simple-obfs/
│       │   ├── libev/
│       │   ├── libancillary/
│       │   └── include/
│       ├── kotlin/                   # Kotlin source (new)
│       │   └── com/github/shadowsocks/plugin/obfs_local/
│       │       ├── BinaryProvider.kt
│       │       ├── ConfigActivity.kt
│       │       └── ConfigFragment.kt
│       └── res/                      # Android resources
├── gradle/
│   └── wrapper/
│       └── gradle-wrapper.properties
├── build.gradle.kts                  # Root build config
├── settings.gradle.kts               # Project settings
├── gradle.properties                 # Gradle properties
├── gradlew                           # Gradle wrapper (Unix)
└── README.md                         # Updated documentation
```

## Building the Project

### Before (SBT):
```bash
sbt clean android:package-release
```

### After (Gradle):
```bash
# Debug build
./gradlew assembleDebug

# Release build
./gradlew assembleRelease
```

## Testing the Migration

1. Initialize submodules:
   ```bash
   git submodule update --init --recursive
   ```

2. Build debug APK:
   ```bash
   ./gradlew assembleDebug
   ```

3. Verify APK is generated:
   ```bash
   ls -lh app/build/outputs/apk/debug/
   ```

## Cleanup Recommendations

After verifying the new build system works, you can safely delete:
- `build.sbt`
- `project/` directory
- `src/main/scala/` directory
- `README_OLD.md`

## Compatibility Notes

- The APK package name remains: `com.github.shadowsocks.plugin.obfs_local`
- Version code: 5
- Version name: 0.0.5
- All functionality preserved from Scala version
- Native library name unchanged: `libobfs-local.so`
- Plugin interface compatibility maintained

## Key Benefits

1. **Modern Tooling**: Gradle is the standard Android build system
2. **Better IDE Support**: Full Android Studio integration
3. **Kotlin Benefits**: Null safety, concise syntax, better Java interop
4. **CMake**: Industry-standard for C/C++ builds
5. **Maintainability**: Easier for new contributors familiar with modern Android development
6. **Performance**: Gradle's incremental builds and build cache
7. **Dependencies**: Access to Maven Central and Google's Android repositories

## Notes

- All native code (C) remains unchanged
- Plugin functionality is identical
- Compatible with same shadowsocks-android versions
- Git submodules preserved (simple-obfs, libev, etc.)
