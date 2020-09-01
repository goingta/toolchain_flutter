package com.doctorwork.flutter.toolchain

import android.os.Bundle
import com.doctorwork.flutter.toolchain.plugins.WeChatPlugin
import io.flutter.embedding.android.FlutterActivity

class MainActivity : FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        flutterEngine?.plugins?.add(WeChatPlugin())
    }
}