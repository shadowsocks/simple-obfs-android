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

  def onInitializePluginOptions(options: PluginOptions): Unit = {
    this.options = options
    for (key <- Array("obfs", "obfs-host")) {
      val pref = findPreference(key)
      pref match {
        case ddp: DropDownPreference => ddp.setValue(options.get(key))
        case etp: EditTextPreference => etp.setText(options.get(key))
      }
      pref.setOnPreferenceChangeListener((_, value) => {
        options.put(key, value.toString)
        true
      })
    }
  }
}
