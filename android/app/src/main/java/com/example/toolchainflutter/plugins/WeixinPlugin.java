package com.example.toolchainflutter.plugins;

import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.util.Log;
import android.widget.Toast;

import com.example.toolchainflutter.App;
import com.example.toolchainflutter.R;
import com.tencent.mm.opensdk.modelbiz.WXLaunchMiniProgram;
import com.tencent.mm.opensdk.modelmsg.SendMessageToWX;
import com.tencent.mm.opensdk.modelmsg.WXMediaMessage;
import com.tencent.mm.opensdk.modelmsg.WXWebpageObject;
import com.tencent.mm.opensdk.openapi.IWXAPI;
import com.tencent.mm.opensdk.openapi.WXAPIFactory;

import java.util.HashMap;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.view.FlutterView;

public class WeixinPlugin implements MethodChannel.MethodCallHandler {
    private final String TAG = "WeixinPlugin";
    private static final int THUMB_SIZE = 150;
    private static final String CHANNEL = "goingta.flutter.io/share";

    public static final String APP_ID = "wx36017dd6944033f4";

    public static void registerWith(FlutterView flutterView) {
        MethodChannel channel =
                new MethodChannel(flutterView, CHANNEL);
        WeixinPlugin instance = new WeixinPlugin(flutterView.getContext());
        channel.setMethodCallHandler(instance);
    }

    private Context context;

    public WeixinPlugin(Context context) {
        this.context = context;
    }

    @Override
    public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {
        Log.d(TAG, methodCall.method + " " + result.toString() + " " + Thread.currentThread().getName());
        onMethodCallUI(methodCall, result);
//        mHandler.postUI(new Runnable() {
//            @Override
//            public void run() {
//                onMethodCallUI(methodCall, result);
//
//            }
//        });
    }

    private void onMethodCallUI(MethodCall methodCall, MethodChannel.Result result) {
        if (methodCall.method.equals("gotoWechat")) {
            gotoWechat(methodCall, result);
        } else if (methodCall.method.equals("shareToWechat")) {
            shareToWechat(methodCall, result);
        } else {
            Toast.makeText(this.context, "方法" + methodCall.method + "没有实现！", Toast.LENGTH_SHORT).show();
        }
    }

    private void shareToWechat(MethodCall methodCall, MethodChannel.Result result) {
        HashMap<String, String> argumentMap = (HashMap<String, String>) methodCall.arguments;
        IWXAPI api = WXAPIFactory.createWXAPI(context, App.APP_ID, false);
        //app分享
//        ext.webpageUrl = [NSString stringWithFormat:@"https://www.pgyer.com/%@",dic[@"buildKey"]];

        WXWebpageObject webpage = new WXWebpageObject();
        webpage.webpageUrl = String.format("https://www.pgyer.com/%s", argumentMap.get("buildKey"));
        WXMediaMessage msg = new WXMediaMessage(webpage);
//            message.title = [NSString stringWithFormat:@"蒲公英iOS版本(%@:%@)",dic[@"buildVersion"],dic[@"buildBuildVersion"]];
        msg.title = String.format("蒲公英Android版本(%s:%s)", argumentMap.get("buildVersion"), argumentMap.get("buildBuildVersion"));
        msg.description = argumentMap.get("buildUpdateDescription");
        Bitmap bmp = BitmapFactory.decodeResource(context.getResources(), R.mipmap.ic_launcher);
        Bitmap thumbBmp = Bitmap.createScaledBitmap(bmp, THUMB_SIZE, THUMB_SIZE, true);
        bmp.recycle();
        msg.thumbData = Util.bmpToByteArray(thumbBmp, true);
        msg.mediaTagName = argumentMap.get("buildVersion");
//        dic[@"buildVersion"];
        SendMessageToWX.Req req = new SendMessageToWX.Req();
        req.transaction = buildTransaction("webpage");
        req.message = msg;
        req.scene = SendMessageToWX.Req.WXSceneSession;
        api.sendReq(req);

    }

    private String buildTransaction(final String type) {
        return (type == null) ? String.valueOf(System.currentTimeMillis()) : type + System.currentTimeMillis();
    }

    private void gotoWechat(MethodCall methodCall, MethodChannel.Result result) {
        Toast.makeText(context, "开始跳转小程序", Toast.LENGTH_SHORT).show();
        String appId = App.APP_ID; // 填应用AppId
        IWXAPI api = WXAPIFactory.createWXAPI(context, appId);
//
        WXLaunchMiniProgram.Req req = new WXLaunchMiniProgram.Req();
        req.userName = methodCall.arguments.toString(); // 填小程序原始id
        req.miniprogramType = WXLaunchMiniProgram.Req.MINIPTOGRAM_TYPE_RELEASE;// 可选打开 开发版，体验版和正式版
        api.sendReq(req);
    }
}
