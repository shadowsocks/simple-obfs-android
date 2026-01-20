package com.github.shadowsocks.plugin

class PluginOptions(val options: String = "") {
    private val map = mutableMapOf<String, String>()

    init {
        // Parse options string if provided
        if (options.isNotEmpty()) {
            options.split(";").forEach { part ->
                val kv = part.split("=", limit = 2)
                if (kv.size == 2) {
                    map[kv[0]] = kv[1]
                }
            }
        }
    }

    operator fun get(key: String): String? = map[key]

    operator fun set(key: String, value: String) {
        map[key] = value
    }

    fun getOrDefault(key: String, defaultValue: String): String = map[key] ?: defaultValue

    fun put(key: String, value: String) {
        map[key] = value
    }

    override fun toString(): String {
        return map.entries.joinToString(";") { "${it.key}=${it.value}" }
    }

    override fun equals(other: Any?): Boolean {
        if (this === other) return true
        if (other !is PluginOptions) return false
        return map == other.map
    }

    override fun hashCode(): Int = map.hashCode()
}
