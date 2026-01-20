package com.github.shadowsocks.plugin

import androidx.appcompat.app.AppCompatActivity

abstract class ConfigurationActivity : AppCompatActivity() {
    abstract fun onInitializePluginOptions(options: PluginOptions)

    protected fun saveChanges(options: PluginOptions) {
        // Stub - actual implementation provided by shadowsocks-android
    }
}
