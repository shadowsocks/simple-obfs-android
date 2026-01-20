# Setup Instructions

## Quick Start

To complete the Gradle setup and build the project, follow these steps:

### 1. Download Gradle Wrapper JAR

The Gradle wrapper JAR file is required but cannot be committed to git initially. Download it by running:

```bash
# The gradlew script will automatically download the wrapper JAR on first run
./gradlew --version
```

This will download `gradle/wrapper/gradle-wrapper.jar` automatically.

**Alternative method** (if you have Gradle installed):
```bash
gradle wrapper --gradle-version 8.5 --distribution-type all
```

### 2. Initialize Git Submodules

```bash
git submodule update --init --recursive
```

This will clone the required dependencies:
- simple-obfs
- libev
- libancillary

### 3. Set Up Android SDK

Ensure you have the Android SDK installed and set the environment variable:

```bash
export ANDROID_HOME=/path/to/android-sdk
# For example on macOS/Linux:
# export ANDROID_HOME=$HOME/Android/Sdk
# On Windows:
# set ANDROID_HOME=C:\Users\YourName\AppData\Local\Android\Sdk
```

### 4. Install Required SDK Components

Using Android Studio SDK Manager or `sdkmanager`, install:
- Android SDK Platform 34
- Android SDK Build-Tools 34.0.0 or higher
- Android NDK (latest version)
- CMake 3.22.1 or higher

**Via command line:**
```bash
$ANDROID_HOME/cmdline-tools/latest/bin/sdkmanager "platforms;android-34" "build-tools;34.0.0" "ndk;26.1.10909125" "cmake;3.22.1"
```

### 5. Build the Project

**Debug build:**
```bash
./gradlew assembleDebug
```

**Release build:**
```bash
./gradlew assembleRelease
```

The APK will be generated in:
- Debug: `app/build/outputs/apk/debug/app-debug.apk`
- Release: `app/build/outputs/apk/release/app-release.apk`

### 6. Install to Device

```bash
# Install debug APK
./gradlew installDebug

# Or manually
adb install app/build/outputs/apk/debug/app-debug.apk
```

## Troubleshooting

### Issue: "Permission denied" when running gradlew

**Solution:**
```bash
chmod +x gradlew
```

### Issue: Submodules not found

**Solution:**
```bash
git submodule update --init --recursive
```

### Issue: CMake not found

**Solution:**
Install CMake via Android Studio SDK Manager or specify the version in `local.properties`:
```properties
cmake.dir=/path/to/cmake
```

### Issue: NDK not found

**Solution:**
Install NDK via Android Studio SDK Manager or set in `local.properties`:
```properties
ndk.dir=/path/to/ndk
```

### Issue: Build fails with "SDK location not found"

**Solution:**
Create `local.properties` in the project root:
```properties
sdk.dir=/path/to/android-sdk
```

## Development Workflow

### Clean build:
```bash
./gradlew clean
./gradlew assembleDebug
```

### Run tests:
```bash
./gradlew test
```

### Check dependencies:
```bash
./gradlew app:dependencies
```

### Generate APK and list outputs:
```bash
./gradlew assembleRelease
find app/build/outputs -name "*.apk"
```

## IDE Setup

### Android Studio

1. Open Android Studio
2. Select "Open an existing project"
3. Navigate to the project root directory
4. Click "OK"
5. Wait for Gradle sync to complete
6. Select "Build" → "Make Project"

Android Studio will automatically:
- Download Gradle wrapper if missing
- Sync Gradle files
- Index the project
- Configure the NDK and CMake

## Next Steps

After successful build:

1. Test the APK on a device or emulator
2. Verify the plugin works with shadowsocks-android
3. If everything works, clean up old files:
   ```bash
   rm -rf build.sbt project/ src/main/scala/ README_OLD.md
   git add .
   git commit -m "Refactor: Migrate from SBT/Scala to Gradle/Kotlin with CMake"
   ```

## Additional Resources

- [Gradle User Guide](https://docs.gradle.org/current/userguide/userguide.html)
- [Android Gradle Plugin Guide](https://developer.android.com/build)
- [Kotlin Documentation](https://kotlinlang.org/docs/home.html)
- [CMake Documentation](https://cmake.org/documentation/)
- [NDK Build Guide](https://developer.android.com/ndk/guides/build)
