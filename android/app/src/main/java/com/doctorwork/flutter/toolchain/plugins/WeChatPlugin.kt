package com.doctorwork.flutter.toolchain.plugins

import android.content.Context
import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.util.Log
import android.widget.Toast
import com.doctorwork.flutter.toolchain.R
import com.tencent.mm.opensdk.modelbiz.WXLaunchMiniProgram
import com.tencent.mm.opensdk.modelmsg.SendMessageToWX
import com.tencent.mm.opensdk.modelmsg.WXMediaMessage
import com.tencent.mm.opensdk.modelmsg.WXWebpageObject
import com.tencent.mm.opensdk.openapi.WXAPIFactory
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.PluginRegistry
import io.flutter.view.FlutterView
import java.util.*

class WeChatPlugin() : FlutterPlugin, MethodCallHandler {

    companion object {
        private const val TAG = "WeChatPlugin"

        private const val THUMB_SIZE = 100

        private const val METHOD_CHANNEL_NAME = "goingta.flutter.io/share"

        private const val APP_ID = "wx36017dd6944033f4";

        private lateinit var context:Context;

        fun registerWith(registrar: PluginRegistry.Registrar) {
            val channel = MethodChannel(registrar.messenger(), METHOD_CHANNEL_NAME)
            context = registrar.context()
            channel.setMethodCallHandler(WeChatPlugin())
        }
    }

    override fun onMethodCall(methodCall: MethodCall, result: MethodChannel.Result) {
        Log.d(TAG, methodCall.method + " " + result.toString() + " " + Thread.currentThread().name)
        onMethodCallUI(methodCall, result)
    }

    private fun onMethodCallUI(methodCall: MethodCall, result: MethodChannel.Result) {
        when (methodCall.method) {
            "gotoWechat" -> {
                gotoWechat(methodCall, result)
            }
            "shareToWechat" -> {
                shareToWechat(methodCall, result)
            }
            else -> {
                Toast.makeText(context, "方法" + methodCall.method + "没有实现！", Toast.LENGTH_SHORT).show()
            }
        }
    }

    private fun shareToWechat(methodCall: MethodCall, result: MethodChannel.Result) {
        val argumentMap = methodCall.arguments as HashMap<String, String>
        val api = WXAPIFactory.createWXAPI(context, APP_ID)

        val webpage = WXWebpageObject()
        webpage.webpageUrl = String.format("https://www.pgyer.com/%s", argumentMap["buildKey"])
        val message = WXMediaMessage(webpage)
        message.title = String.format("蒲公英Android版本(%s:%s)", argumentMap["buildVersion"], argumentMap["buildBuildVersion"])
        message.description = argumentMap.get("buildUpdateDescription")
        message.setThumbImage(Bitmap.createScaledBitmap(BitmapFactory.decodeResource(context.resources, R.mipmap.ic_launcher), THUMB_SIZE, THUMB_SIZE, true))
        message.mediaTagName = argumentMap["buildVersion"];

        val req = SendMessageToWX.Req()
        req.transaction = buildTransaction("webpage")
        req.message = message
        req.scene = SendMessageToWX.Req.WXSceneSession
        api.sendReq(req)
    }

    private fun buildTransaction(type: String): String {
        return type + System.currentTimeMillis()
    }

    private fun gotoWechat(methodCall: MethodCall, result: MethodChannel.Result) {
        Toast.makeText(context, "开始跳转小程序", Toast.LENGTH_SHORT).show()
        val api = WXAPIFactory.createWXAPI(context, APP_ID)
        //
        val req = WXLaunchMiniProgram.Req()
        // 填小程序原始id
        req.userName = methodCall.arguments.toString()
        // 可选打开 开发版，体验版和正式版
        req.miniprogramType = WXLaunchMiniProgram.Req.MINIPTOGRAM_TYPE_RELEASE
        api.sendReq(req)
    }

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        Log.d(TAG, "onAttachedToEngine")
        val channel = MethodChannel(binding.binaryMessenger, METHOD_CHANNEL_NAME)
        context = binding.applicationContext
        channel.setMethodCallHandler(this)
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        Log.d(TAG, "onDetachedFromEngine")
    }
}