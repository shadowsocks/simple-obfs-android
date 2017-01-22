## simple-obfs for Android

[simple-obfs](https://github.com/shadowsocks/simple-obfs) plugin for [shadowsocks-android](https://github.com/shadowsocks/shadowsocks-android). 

### CI STATUS

[![Build Status](https://api.travis-ci.org/shadowsocks/simple-obfs-android.svg)](https://travis-ci.org/shadowsocks/simple-obfs-android)

### PREREQUISITES

* JDK 1.8
* SBT 0.13.0+
* Android SDK
  - Build Tools 25+
  - Android Support Repository (see `build.sbt` for version)
* Android NDK r12b+

### BUILD

* Set environment variable `ANDROID_HOME` to `/path/to/android-sdk`
* Set environment variable `ANDROID_NDK_HOME` to `/path/to/android-ndk`
* Create your key following the instructions at https://developer.android.com/studio/publish/app-signing.html
* Create `local.properties` from `local.properties.example` with your own key information
* Invoke the building like this

```bash
    git submodule update --init --recursive

    # Build the App
    sbt clean android:package-release
```

### TRANSLATE

This plugin is an official plugin thus you can see [shadowsocks-android](https://github.com/shadowsocks/shadowsocks-android/blob/master/README.md#translate)'s instructions to translate this plugin's UI.

## OPEN SOURCE LICENSES

<ul>
    <li>libancillary: <a href="https://github.com/shadowsocks/libancillary/blob/shadowsocks-android/COPYING">BSD</a></li>
    <li>simple-obfs: <a href="https://github.com/shadowsocks/simple-obfs/blob/master/LICENSE">GPLv3</a></li>
    <li>libev: <a href="https://github.com/shadowsocks/shadowsocks-libev/blob/master/libev/LICENSE">GPLv2</a></li>
    <li>libsodium: <a href="https://github.com/jedisct1/libsodium/blob/master/LICENSE">ISC</a></li>
    <li>libudns: <a href="https://github.com/shadowsocks/libudns/blob/master/COPYING.LGPL">LGPL</a></li>
</ul>

### LICENSE

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
