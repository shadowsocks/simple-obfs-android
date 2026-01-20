package com.github.shadowsocks.plugin.obfs_local

import android.os.Bundle
import android.view.MenuItem
import androidx.appcompat.app.AlertDialog
import androidx.appcompat.widget.Toolbar
import com.github.shadowsocks.plugin.ConfigurationActivity
import com.github.shadowsocks.plugin.PluginOptions

/**
 * @author Mygod
 */
class ConfigActivity : ConfigurationActivity(), Toolbar.OnMenuItemClickListener {
    private val child: ConfigFragment
        get() = supportFragmentManager.findFragmentById(R.id.content) as ConfigFragment

    private var oldOptions: PluginOptions? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_config)

        val toolbar = findViewById<Toolbar>(R.id.toolbar)
        toolbar.apply {
            setTitle(title)
            setNavigationIcon(R.drawable.ic_navigation_close)
            setNavigationOnClickListener { onBackPressed() }
            inflateMenu(R.menu.menu_config)
            setOnMenuItemClickListener(this@ConfigActivity)
        }
    }

    override fun onInitializePluginOptions(options: PluginOptions) {
        oldOptions = options
        child.onInitializePluginOptions(options)
    }

    override fun onMenuItemClick(item: MenuItem): Boolean {
        return when (item.itemId) {
            R.id.action_apply -> {
                child.options?.let { saveChanges(it) }
                finish()
                true
            }
            else -> false
        }
    }

    override fun onBackPressed() {
        val currentOptions = child.options
        if (currentOptions != oldOptions) {
            AlertDialog.Builder(this)
                .setTitle(R.string.unsaved_changes_prompt)
                .setPositiveButton(R.string.yes) { _, _ ->
                    currentOptions?.let { saveChanges(it) }
                }
                .setNegativeButton(R.string.no) { _, _ ->
                    finish()
                }
                .setNeutralButton(android.R.string.cancel, null)
                .show()
        } else {
            super.onBackPressed()
        }
    }
}
