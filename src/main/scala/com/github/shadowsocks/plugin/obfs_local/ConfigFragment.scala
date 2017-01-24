package com.github.shadowsocks.plugin.obfs_local

import android.os.Bundle
import android.support.v7.preference.DropDownPreference
import be.mygod.preference.{EditTextPreference, PreferenceFragment}
import com.github.shadowsocks.plugin.PluginOptions

/**
  * @author Mygod
  */
class ConfigFragment extends PreferenceFragment {
  var options: PluginOptions = _

  override def onCreatePreferences(bundle: Bundle, key: String): Unit = addPreferencesFromResource(R.xml.config)

  def getOrDefault(options: PluginOptions, key: String, defaultValue: String): String = {
    options.get(key) match {
      case v: String => v
      case _ => defaultValue
    }
  }

  def onInitializePluginOptions(options: PluginOptions): Unit = {
    this.options = options
    for ((key, defaultValue) <- Array(("obfs", "http"), ("obfs-host", "cloudfront.net"))) {
      val pref = findPreference(key)
      pref match {
        case ddp: DropDownPreference => ddp.setValue(getOrDefault(options, key, defaultValue))
        case etp: EditTextPreference => etp.setText(getOrDefault(options, key, defaultValue))
      }
      pref.setOnPreferenceChangeListener((_, value) => {
        options.put(key, value.toString)
        true
      })
    }
  }
}
