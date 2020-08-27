package com.doctorwork.flutter.toolchain

import android.os.Bundle
import com.doctorwork.flutter.toolchain.plugins.WeChatPlugin
import io.flutter.app.FlutterActivity
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity : FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        GeneratedPluginRegistrant.registerWith(this)
        WeChatPlugin.registerWith(flutterView)
    }
}