package com.github.shadowsocks.plugin

interface PathProvider {
    fun addPath(name: String, mode: String)
}
