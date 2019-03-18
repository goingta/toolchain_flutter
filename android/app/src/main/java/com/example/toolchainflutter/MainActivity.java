package com.example.toolchainflutter;

import android.os.Bundle;

import com.example.toolchainflutter.plugins.WeixinPlugin;

import io.flutter.app.FlutterActivity;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        GeneratedPluginRegistrant.registerWith(this);
        WeixinPlugin.registerWith(getFlutterView());
    }
}
