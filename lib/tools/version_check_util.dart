import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import 'package:toolchain_flutter/model/pgy_update_model.dart';
import 'package:toolchain_flutter/network/pgyer_network.dart';
import 'package:toolchain_flutter/notifier/version_update_change_notifier.dart';
import 'package:toolchain_flutter/theme/light_color.dart';
import 'package:url_launcher/url_launcher.dart';

class VersionCheckUtil {
  /// 检查更新
  static Future<void> checkUpdate(BuildContext context, bool isManual) async {
    try {
      PGYUpdateModel pgyUpdateModel = await PGYNetwork().checkUpdate();
      if (pgyUpdateModel != null) {
        final int serverVersion = int.parse(pgyUpdateModel.buildVersion
            .split(".")
            .reduce((value, element) => value + element));
        // 判断版本号
        final int currentVersion = int.parse((await PackageInfo.fromPlatform())
            .version
            .split(".")
            .reduce((value, element) => value + element));
        print(
            "currentVersion = $currentVersion, serviceVersion = $serverVersion");
        if (serverVersion > currentVersion) {
          VersionUpdateChangeNotifier versionUpdateChangeNotifier =
              Provider.of<VersionUpdateChangeNotifier>(context, listen: false);
          versionUpdateChangeNotifier.downloadURL = pgyUpdateModel.downloadURL;
          versionUpdateChangeNotifier.hasNewVersion = true;
          _showUpdateDialog(context, pgyUpdateModel);
        } else if (isManual) {
          Toast.show("当前为最新版本", context);
        }
      }
    } catch (e) {
      print(e);
      if (isManual) {
        Toast.show(e.toString(), context);
      }
    }
  }

  /// 弹框
  static void _showUpdateDialog(
      BuildContext context, PGYUpdateModel pgyUpdateModel) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              '发现新版本',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold),
            ),
            content: Text(
              pgyUpdateModel.buildUpdateDescription,
            ),
            actions: [
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  '取消',
                  style: TextStyle(color: LightColor.primaryColor),
                ),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  launch(pgyUpdateModel.downloadURL);
                },
                child: Text(
                  '升级',
                  style: TextStyle(color: LightColor.primaryColor),
                ),
              ),
            ],
          );
        });
  }
}
