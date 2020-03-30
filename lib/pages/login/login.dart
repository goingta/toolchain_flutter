import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluwx_worker/fluwx_worker.dart' as fluwxWorker;
import 'package:toolchain_flutter/common/Global.dart';
import '../tabPage/tabPage.dart';
import '../tabPage/homePage.dart';
import '../../model/user.dart';

class LoginPage extends StatefulWidget {
  static const String id = "/login";

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController =
      TextEditingController(text: "flutter@doctorwork.com");
  final _passwordController =
      TextEditingController(text: "flutter@doctorwork.com");

  var _result = 'None';

  bool loading = false;
  String errorMessage = "";

  String _email = "";
  String _password = "";

  @override
  void initState() {
    super.initState();
    _initFluwx();
  }

  // 跳转到登录成功首页
  void pushToHomePage() {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => new HomePage()));

    // Navigator.pushReplacementNamed(context, TabPage.id);
  }

  _initFluwx() async {
    await fluwxWorker.register(
        schema: Global.schema, corpId: Global.corpId, agentId: Global.agentId);
    var result = await fluwxWorker.isWeChatInstalled();
    print("is installed $result");

    //等待授权结果
    fluwxWorker.responseFromAuth.listen((data) async {
      print("data.code => ${data.code}");
      if (data.errCode == 0) {
        _result = data.code; //后续用这个code再发http请求取得UserID
        // Navigator.pushNamed(context, TabPage.id);
        bool result = await User.fluwxWorkerSignIn(data.code);
        if (result) {
          // Navigator.pushNamed(context, TabPage.id);
          this.pushToHomePage();
        }
      } else if (data.errCode == 1) {
        _result = '授权失败';
      } else {
        _result = '用户取消';
      }
      setState(() {});
    });
  }

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return '请输入正确的邮箱地址';
    else
      return null;
  }

  void _submitForm() async {
    if (_formKey.currentState.validate()) {
      try {
        setState(() {
          loading = true;
        });

        final result = await User.signIn("xxx", "xx");
        if (result) {
          this.pushToHomePage();
        }
      } catch (e) {
        setState(() {
          loading = false;
          switch (e.code) {
            case "ERROR_INVALID_EMAIL":
              errorMessage = "你的邮箱地址格式不正确";
              break;
            case "ERROR_WRONG_PASSWORD":
              errorMessage = "密码错误";
              break;
            case "ERROR_USER_NOT_FOUND":
              errorMessage = "未查找到对应用户";
              break;
            case "ERROR_USER_DISABLED":
              errorMessage = "User with this email has been disabled.";
              break;
            case "ERROR_TOO_MANY_REQUESTS":
              errorMessage = "Too many requests. Try again later.";
              break;
            default:
              errorMessage = "登录失败，请联系管理员";
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: loading
          ? Center(
              child: SpinKitDoubleBounce(
                color: Theme.of(context).primaryColor,
                size: 50.0,
              ),
            )
          : Stack(
              fit: StackFit.expand,
              children: <Widget>[
                SafeArea(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "企鹅杏仁工具链",
                          style: Theme.of(context)
                              .textTheme
                              .headline
                              .copyWith(color: Theme.of(context).primaryColor),
                        ),
                        SizedBox(height: 36),
                        Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                                controller: _emailController,
                                validator: (value) => validateEmail(value),
                                onFieldSubmitted: (v) {
                                  FocusScope.of(context).nextFocus();
                                  this._email = v;
                                },
                                decoration: InputDecoration(
                                  labelText: "邮箱",
                                  prefixIcon: Icon(Icons.email),
                                ),
                              ),
                              SizedBox(height: 12),
                              TextFormField(
                                keyboardType: TextInputType.text,
                                controller: _passwordController,
                                validator: (value) {
                                  if (value.length < 8) return "密码必须超过8个字符";
                                  return null;
                                },
                                onFieldSubmitted: (v) {
                                  this._password = v;
                                },
                                decoration: InputDecoration(
                                  labelText: "密码",
                                  prefixIcon: Icon(Icons.lock),
                                ),
                                obscureText: true,
                              ),
                              if (errorMessage.length > 0) SizedBox(height: 12),
                              Text(errorMessage,
                                  style: TextStyle(color: Colors.red)),
                              if (errorMessage.length > 0) SizedBox(height: 12),
                              RaisedButton(
                                child: Text("登录"),
                                onPressed: _submitForm,
                              ),
                              RaisedButton(
                                child: Text("企业微信登录",
                                    style: TextStyle(color: Colors.white)),
                                onPressed: () {
                                  // Navigator.pushNamed(context, Register.id);
                                  //企业微信授权
                                  fluwxWorker.sendAuth(
                                      schema: Global.schema,
                                      appId: Global.corpId,
                                      agentId: Global.agentId);
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 30),
                        Image(
                          image: AssetImage(
                            'assets/graphics/not-found.png',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
