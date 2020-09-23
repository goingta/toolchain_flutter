import 'package:toolchain_flutter/model/program_item_model.dart';

class H5ProgramItemModel extends ProgramItemModel {
  final List<H5Env> envs;

  H5ProgramItemModel.fromJson(Map<String, dynamic> json)
      : envs = (json['envs'] as List<dynamic>)
            .map((e) => H5Env.fromJson(e))
            .toList(),
        super.fromJson(json);
}

class H5Env {
  final String name;
  final String url;

  H5Env.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        url = json['url'];
}
