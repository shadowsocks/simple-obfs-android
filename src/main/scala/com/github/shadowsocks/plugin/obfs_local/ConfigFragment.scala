package com.github.shadowsocks.plugin.obfs_local

import android.os.Bundle
import android.support.v7.preference.DropDownPreference
import android.view.View
import be.mygod.preference.{EditTextPreference, PreferenceFragment}
import com.github.shadowsocks.plugin.{PluginContract, PluginOptions}

/**
  * @author Mygod
  */
class ConfigFragment extends PreferenceFragment {
  var options: PluginOptions = _

  override def onCreatePreferences(bundle: Bundle, key: String): Unit = addPreferencesFromResource(R.xml.config)

  def onInitializePluginOptions(options: PluginOptions): Unit = {
    this.options = options
    for ((key, defaultValue) <- Array(("obfs", "http"), ("obfs-host", "cloudfront.net"), ("obfs-uri", "/"))) {
      val pref = findPreference(key)
      pref match {
        case ddp: DropDownPreference => ddp.setValue(options.getOrDefault(key, defaultValue))
        case etp: EditTextPreference => etp.setText(options.getOrDefault(key, defaultValue))
      }
      pref.setOnPreferenceChangeListener((_, value) => {
        options.put(key, value.toString)
        true
      })
    }
  }

  override def onSaveInstanceState(outState: Bundle) {
    super.onSaveInstanceState(outState)
    outState.putString(PluginContract.EXTRA_OPTIONS, options.toString)
  }
  override def onViewCreated(view: View, savedInstanceState: Bundle) {
    super.onViewCreated(view, savedInstanceState)
    if (savedInstanceState != null) {
      options = new PluginOptions(savedInstanceState.getString(PluginContract.EXTRA_OPTIONS))
      onInitializePluginOptions(options)
    }
  }
}
