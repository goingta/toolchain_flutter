import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';
import 'package:toolchain_flutter/model/user.dart';
import 'package:toolchain_flutter/model/user_model.dart';
import 'package:toolchain_flutter/notifier/version_update_change_notifier.dart';
import 'package:toolchain_flutter/pages/login/login_page.dart';
import 'package:toolchain_flutter/pages/webview/web_view_page.dart';
import 'package:toolchain_flutter/router/nav_key.dart';
import 'package:toolchain_flutter/theme/light_color.dart';
import 'package:toolchain_flutter/tools/version_check_util.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePage extends StatefulWidget {
  static const String id = "/profile_page";

  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<ProfilePage> {
  UserModel _user;

  // 版本号
  String _version;

  // 编译版本
  String _buildNumber;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text(
          "个人中心",
        ),
      ),
      body: _user == null
          ? Center(
              child: SpinKitDoubleBounce(
                color: Theme.of(context).primaryColor,
                size: 50.0,
              ),
            )
          : ListView(
              padding: EdgeInsets.fromLTRB(
                10.0,
                20.0,
                10.0,
                0,
              ),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: 10.0,
                        right: 10.0,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                          12.0,
                        ),
                        child: Container(
                          width: 100.0,
                          height: 100.0,
                          child: Image.network(
                            _user.avatar == null ? '' : _user.avatar,
                            width: 100.0,
                            height: 100.0,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                _user.name == null ? '' : _user.name,
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 5.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                _user.email == null ? '' : _user.email,
                                style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                _user.position == null ? '' : _user.position,
                                style: TextStyle(
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.w400,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ],
                      ),
                      flex: 3,
                    ),
                  ],
                ),
                Divider(),
                ListTile(
                  title: Text(
                    "姓名",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  subtitle: Text(
                    _user.name == null ? '' : _user.name,
                  ),
                ),
                Divider(),
                ListTile(
                  title: Text(
                    "Email",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  subtitle: Text(
                    _user.email == null ? '' : _user.email,
                  ),
                ),
                Divider(),
                SizedBox(height: 10.0),                ListTile(
                  title: Text(
                    "意见反馈",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  onTap: () {
                    NavKey.navKey.currentState
                            .pushNamed(WebViewPage.id, arguments: {
                          "title":  "意见反馈",
                          "url": "https://support.qq.com/product/284036",
                        });
                  },
                ),
                Divider(),
                SizedBox(height: 10.0),
                Consumer<VersionUpdateChangeNotifier>(
                  builder: (BuildContext context,
                      VersionUpdateChangeNotifier versionUpdateChangeNotifier,
                      Widget child) {
                    return ListTile(
                      title: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "版本",
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          versionUpdateChangeNotifier.hasNewVersion
                              ? Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 5.0,
                                    vertical: 3.0,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(
                                        10.0,
                                      ),
                                    ),
                                  ),
                                  child: Text(
                                    "New",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                    ),
                                  ),
                                )
                              : SizedBox.shrink(),
                        ],
                      ),
                      trailing: Text("V$_version [$_buildNumber]"),
                      onTap: () {
                        if (versionUpdateChangeNotifier.hasNewVersion) {
                          // 跳转页面
                          launch(versionUpdateChangeNotifier.downloadURL);
                        } else {
                          // 检查更新
                          VersionCheckUtil.checkUpdate(context, true);
                        }
                      },
                    );
                  },
                ),
                SizedBox(height: 40.0),
                RaisedButton(
                  child: Text("退出登录"),
                  textColor: Colors.white,
                  onPressed: _logout,
                ),
                SizedBox(
                  height: 40.0,
                ),
              ],
            ),
    );
  }

  Future<Null> _loadData() async {
    UserModel user = await User.getCurrentUser();
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    if (mounted) {
      setState(() {
        _version = packageInfo.version;
        _buildNumber = packageInfo.buildNumber;
        _user = user;
      });
    }
  }

  Future<void> _logout() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('提示'),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text('是否确认退出登录'),
              ],
            ),
          ),
          actions: [
            FlatButton(
              child: Text(
                '取消',
                style: TextStyle(color: LightColor.primaryColor),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text(
                '退出',
                style: TextStyle(color: LightColor.primaryColor),
              ),
              onPressed: () {
                User.signOut();
                Navigator.of(context).pop();
                Navigator.pushReplacementNamed(context, LoginPage.id);
              },
            )
          ],
        );
      },
    );
  }
}
