import '../../../src_exports.dart';

class UserModel {
  UserModel({
    this.id = "",
    this.apiKey = "",
    this.token = "",
  });
  String id;
  String apiKey;
  String token;

  bool get hasUser => id.isNotEmpty && id != "0";

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json[KeyConst.id].toString(),
      apiKey: json[KeyConst.apiKey] ?? "",
      token: json[KeyConst.token] ?? "",
    );
  }

  toJson() => {};
  
  updateUserJson() => {};
}
