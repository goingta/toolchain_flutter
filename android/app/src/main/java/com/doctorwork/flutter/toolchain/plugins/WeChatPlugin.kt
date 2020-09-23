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
import com.tencent.mm.opensdk.modelmsg.WXMiniProgramObject
import com.tencent.mm.opensdk.modelmsg.WXWebpageObject
import com.tencent.mm.opensdk.openapi.WXAPIFactory
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import java.util.*

class WeChatPlugin : FlutterPlugin, MethodCallHandler {

    companion object {
        private const val TAG = "WeChatPlugin"

        private const val THUMB_SIZE = 100

        private const val METHOD_CHANNEL_NAME = "goingta.flutter.io/share"

         const val APP_ID = "wx36017dd6944033f4"

        private lateinit var context: Context
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
            "sendReqToWechat" -> {
                sendReqToWechat(methodCall, result)
            }
            else -> {
                Toast.makeText(context, "方法" + methodCall.method + "没有实现！", Toast.LENGTH_SHORT).show()
            }
        }
    }

    private fun sendReqToWechat(methodCall: MethodCall, result: MethodChannel.Result) {
        val argumentMap = methodCall.arguments as HashMap<*, *>


        val title = argumentMap["title"] as String
        val description = argumentMap["description"] as String
        val mediaTagName = argumentMap["mediaTagName"] as String
        val pageUrl = argumentMap["pageUrl"] as String

        val type = argumentMap["type"] as String

        var wxObject: WXMediaMessage.IMediaObject? = null
        if (type == "webPage") {
            wxObject = WXWebpageObject()
            wxObject.webpageUrl = pageUrl
        } else if (type == "miniProgram") {
            var miniprogramType = WXLaunchMiniProgram.Req.MINIPTOGRAM_TYPE_RELEASE
            val programType = argumentMap["programType"] as String

            if (programType == "test") {
                miniprogramType = WXLaunchMiniProgram.Req.MINIPROGRAM_TYPE_TEST
            } else if (programType == "preview") {
                miniprogramType = WXLaunchMiniProgram.Req.MINIPROGRAM_TYPE_PREVIEW
            } else if (programType == "release") {
                miniprogramType = WXLaunchMiniProgram.Req.MINIPTOGRAM_TYPE_RELEASE
            }

            wxObject = WXMiniProgramObject()
            wxObject.webpageUrl = pageUrl
            wxObject.userName = argumentMap["userName"] as String
            wxObject.path = argumentMap["path"] as String
            wxObject.withShareTicket = argumentMap["withShareTicket"] as Boolean
            wxObject.miniprogramType = miniprogramType
        }

        val wxMediaMessage = WXMediaMessage()
        wxMediaMessage.title = title
        wxMediaMessage.description = description
        wxMediaMessage.mediaTagName = mediaTagName
        wxMediaMessage.mediaObject = wxObject
        wxMediaMessage.setThumbImage(Bitmap.createScaledBitmap(BitmapFactory.decodeResource(context.resources, R.mipmap.ic_launcher), THUMB_SIZE, THUMB_SIZE, true))

        val req = SendMessageToWX.Req()
        req.message = wxMediaMessage
        req.scene = SendMessageToWX.Req.WXSceneSession
        WXAPIFactory.createWXAPI(context, APP_ID).sendReq(req)
        result.success(null)
    }

    private fun gotoWechat(methodCall: MethodCall, result: MethodChannel.Result) {
        try {
            val argumentMap = methodCall.arguments as HashMap<*, *>

            var miniprogramType = WXLaunchMiniProgram.Req.MINIPTOGRAM_TYPE_RELEASE
            val programType = argumentMap["programType"] as String

            if (programType == "test") {
                miniprogramType = WXLaunchMiniProgram.Req.MINIPROGRAM_TYPE_TEST
            } else if (programType == "preview") {
                miniprogramType = WXLaunchMiniProgram.Req.MINIPROGRAM_TYPE_PREVIEW
            } else if (programType == "release") {
                miniprogramType = WXLaunchMiniProgram.Req.MINIPTOGRAM_TYPE_RELEASE
            }

            val userName = argumentMap["appid"] as String

            val req = WXLaunchMiniProgram.Req()
            // 填小程序原始id
            req.userName = userName
            // 可选打开 开发版，体验版和正式版
            req.miniprogramType = miniprogramType
            WXAPIFactory.createWXAPI(context, APP_ID).sendReq(req)
            result.success(null)
        } catch (e: Exception) {
            e.printStackTrace()
        }
        result.error("-1", null, null)
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