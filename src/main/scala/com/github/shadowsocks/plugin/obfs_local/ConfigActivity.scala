package com.github.shadowsocks.plugin.obfs_local

import android.content.DialogInterface
import android.os.Bundle
import android.support.v7.app.AlertDialog
import android.support.v7.widget.Toolbar
import android.view.MenuItem
import com.github.shadowsocks.plugin.{ConfigurationActivity, PluginOptions}

/**
  * @author Mygod
  */
class ConfigActivity extends ConfigurationActivity with Toolbar.OnMenuItemClickListener {
  private lazy val child = getFragmentManager.findFragmentById(R.id.content).asInstanceOf[ConfigFragment]
  private var oldOptions: PluginOptions = _

  override def onCreate(savedInstanceState: Bundle) {
    super.onCreate(savedInstanceState)
    setContentView(R.layout.activity_config)
    val toolbar = findViewById(R.id.toolbar).asInstanceOf[Toolbar]
    toolbar.setTitle(getTitle)
    toolbar.setNavigationIcon(R.drawable.ic_navigation_close)
    toolbar.setNavigationOnClickListener(_ => onBackPressed())
    toolbar.inflateMenu(R.menu.menu_config)
    toolbar.setOnMenuItemClickListener(this)
  }

  override protected def onInitializePluginOptions(options: PluginOptions) {
    oldOptions = options
    child.onInitializePluginOptions(options)
  }

  override def onMenuItemClick(item: MenuItem): Boolean = item.getItemId match {
    case R.id.action_apply =>
      saveChanges(child.options)
      finish()
      true
    case _ => false
  }

  override def onBackPressed(): Unit = if (child.options != oldOptions) new AlertDialog.Builder(this)
    .setTitle(R.string.unsaved_changes_prompt)
    .setPositiveButton(R.string.yes, ((_, _) => saveChanges(child.options)): DialogInterface.OnClickListener)
    .setNegativeButton(R.string.no, ((_, _) => finish()): DialogInterface.OnClickListener)
    .setNeutralButton(android.R.string.cancel, null)
    .create()
    .show() else super.onBackPressed()
}
