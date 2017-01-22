package com.github.shadowsocks.plugin.obfs_local

import java.io.{File, FileNotFoundException}

import android.net.Uri
import android.os.ParcelFileDescriptor
import com.github.shadowsocks.plugin.{NativePluginProvider, PathProvider}

/**
  * @author Mygod
  */
final class BinaryProvider extends NativePluginProvider {
  override protected def populateFiles(provider: PathProvider): Unit = provider.addPath("obfs-local", "755")

  override def getExecutable: String = getContext.getApplicationInfo.nativeLibraryDir + "/libobfs-local.so"

  override def openFile(uri: Uri): ParcelFileDescriptor = uri.getPath match {
    case "/obfs-local" => ParcelFileDescriptor.open(new File(getExecutable), ParcelFileDescriptor.MODE_READ_ONLY)
    case _ => throw new FileNotFoundException()
  }
}
