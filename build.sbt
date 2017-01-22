scalaVersion := "2.11.8"

enablePlugins(AndroidApp)
android.useSupportVectors

name := "obfs-local"
organization := "com.github.shadowsocks"
version := "0.0.1"
versionCode := Some(1)

platformTarget := "android-25"

compileOrder := CompileOrder.JavaThenScala
javacOptions ++= "-source" :: "1.7" :: "-target" :: "1.7" :: Nil
scalacOptions ++= "-target:jvm-1.7" :: "-Xexperimental" :: Nil
ndkArgs := "-j" :: java.lang.Runtime.getRuntime.availableProcessors.toString :: Nil

proguardVersion := "5.3.2"
proguardCache := Seq()

shrinkResources := true
typedResources := false
resConfigs := Seq("zh-rCN")

resolvers += "Local Maven Repository" at "file://" + Path.userHome.absolutePath + "/.m2/repository"

libraryDependencies += "com.github.shadowsocks" %% "plugin" % "0.0.1-SNAPSHOT"
