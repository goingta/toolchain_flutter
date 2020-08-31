import 'package:flutter/material.dart';

class VersionUpdateChangeNotifier extends ChangeNotifier {
  // 是否有新版本
  bool _hasNewVersion = false;

  String downloadURL;

  set hasNewVersion(bool hasNewVersion) {
    _hasNewVersion = hasNewVersion;
    notifyListeners();
  }

  get hasNewVersion => _hasNewVersion;
}
