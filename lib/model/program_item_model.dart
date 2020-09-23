import 'package:toolchain_flutter/model/program_type.dart';

class ProgramItemModel {
  final String name;
  final String desc;
  final String owner;
  final String logo;
  ProgramType programType;

  ProgramItemModel.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        desc = json['desc'],
        owner = json['owner'],
        logo = json['logo'],
        programType = ProgramType.valueOf(json['programType']);

  Map<String, dynamic> toJson() => {
        'name': name,
        'desc': desc,
        'owner': owner,
        'logo': logo,
        'programType': programType == null ? null : programType.code,
      };
}
