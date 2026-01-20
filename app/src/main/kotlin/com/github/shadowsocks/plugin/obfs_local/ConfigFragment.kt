package com.github.shadowsocks.plugin.obfs_local

import android.os.Bundle
import androidx.preference.DropDownPreference
import androidx.preference.EditTextPreference
import androidx.preference.PreferenceFragmentCompat
import android.view.View
import com.github.shadowsocks.plugin.PluginContract
import com.github.shadowsocks.plugin.PluginOptions

/**
 * @author Mygod
 */
class ConfigFragment : PreferenceFragmentCompat() {
    var options: PluginOptions? = null

    override fun onCreatePreferences(savedInstanceState: Bundle?, rootKey: String?) {
        setPreferencesFromResource(R.xml.config, rootKey)
    }

    fun onInitializePluginOptions(pluginOptions: PluginOptions) {
        this.options = pluginOptions

        val configs = arrayOf(
            Triple("obfs", "http", null),
            Triple("obfs-host", "cloudfront.net", null),
            Triple("obfs-uri", "/", null)
        )

        for ((key, defaultValue, _) in configs) {
            val pref = findPreference<androidx.preference.Preference>(key)
            when (pref) {
                is DropDownPreference -> {
                    pref.value = pluginOptions.getOrDefault(key, defaultValue)
                }
                is EditTextPreference -> {
                    pref.text = pluginOptions.getOrDefault(key, defaultValue)
                }
            }
            pref?.setOnPreferenceChangeListener { _, newValue ->
                pluginOptions[key] = newValue.toString()
                true
            }
        }
    }

    override fun onSaveInstanceState(outState: Bundle) {
        super.onSaveInstanceState(outState)
        outState.putString(PluginContract.EXTRA_OPTIONS, options.toString())
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        savedInstanceState?.getString(PluginContract.EXTRA_OPTIONS)?.let {
            options = PluginOptions(it)
            options?.let { opts -> onInitializePluginOptions(opts) }
        }
    }
}
