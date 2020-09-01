class UserModel {
  final String name;
  final String avatar;
  final String email;
  final String position;
  final String userId;
  final String token;
  final int normandyUserId;

  UserModel.fromJson(Map<String, dynamic> json)
      : name = json["name"],
        avatar = json["avatar"],
        email = json["email"],
        position = json["position"],
        userId = json["userId"],
        token = json["token"],
        normandyUserId = json["normandyUserId"];

  Map<String, dynamic> toJson() => {
        "name": name,
        "avatar": avatar,
        "email": email,
        "position": position,
        "userId": userId,
        "token": token,
        "normandyUserId": normandyUserId,
      };
}
