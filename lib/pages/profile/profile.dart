import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:toolchain_flutter/model/user_model.dart';
import 'package:toolchain_flutter/theme/light_color.dart';

import '../../model/user.dart';

class ProfilePage extends StatefulWidget {
  @override
  static const String id = "/profile";
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<ProfilePage> with AutomaticKeepAliveClientMixin {
   @override
  bool get wantKeepAlive => true; // 返回true

  UserModel _user;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("个人中心",style: TextStyle(color: Colors.white)),
        backgroundColor: LightColor.primaryColor, //设置appbar背景颜色
        centerTitle: true, //设置标题是否局中
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(10.0,20.0,10.0,0),

        child: _user == null ? Center(
              child: SpinKitDoubleBounce(
                color: Theme.of(context).primaryColor,
                size: 50.0,
              ),
            ) : ListView(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 10.0, right: 10.0),
                  child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Container(
                      width: 100.0,
                      height: 100.0,
                      child: Image.network(_user.avatar,width: 100.0,height: 100.0,fit: BoxFit.cover)),
                  ),
                ),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            _user.name,
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
                        children: <Widget>[
                          Text(
                            _user.email,
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
                        children: <Widget>[
                          Text(_user.position,
                              style: TextStyle(
                                fontSize: 13.0,
                                fontWeight: FontWeight.w400,
                                color: Theme.of(context).accentColor,
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
                _user.name,
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
                _user.email,
              ),
            ),
            Divider(),
            Container(height: 40.0),
            RaisedButton(
                        child: Text("退出登录"),
                        textColor: Colors.white,
                        onPressed: _logout,
                      )
          ],
        ),
      ),
    );
  }

  Future<Null> _loadData() async {
    UserModel user = await User.getCurrentUser();
    setState(() {
      _user = user;
    });
  }

  _logout() {

  }
}


