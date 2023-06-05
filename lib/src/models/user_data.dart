import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  String docId;
  String fName;
  String lName;
  DateTime birthday;
  String phone;
  String countryCode;
  String email;
  String password;
  String profileImgUrl;
  String coverImgUrl;
  bool phoneVerified;
  bool emailVerified;
  bool googleSign;
  bool facebookSign;

  UserData(
      {
      this.docId = "",
      this.fName = "",
      this.lName = "",
      required this.birthday,
      this.phone = "",
      this.countryCode = "",
      this.email = "",
      this.password = "",
      this.profileImgUrl = "",
      this.coverImgUrl = "",
      this.emailVerified = false,
      this.phoneVerified = false,
      this.googleSign = false,
      this.facebookSign = false});

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
        fName: json['fName'] ?? "",
        lName: json['lName'] ?? "",
        // birthday: json['birthday'] ?? "",
        birthday: json['birthday'] != null ? (json['birthday'] as Timestamp).toDate() : DateTime(0),
        phone: json['phone'] ?? "",
        email: json['email'] ?? "",
        profileImgUrl: json['profile_img'] ?? "",
        coverImgUrl: json['cover_img'] ?? "",
        emailVerified: json['email_verified'] ?? false,
        phoneVerified: json['phone_verified'] ?? false,
        googleSign: json['google_sign'] ?? false,
        facebookSign: json['facebook_sign'] ?? false,
        countryCode: json['country_code'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fName'] = fName;
    data['lName'] = lName;
    data['birthday'] = birthday;
    data['phone'] = phone;
    data['country_code'] = countryCode;
    data['email'] = email;
    data['cover_img'] = coverImgUrl;
    data['profile_img'] = profileImgUrl;
    data['email_verified'] = emailVerified;
    data['facebook_sign'] = facebookSign;
    data['phone_verified'] = phoneVerified;
    data['google_sign'] = googleSign;
    return data;
  }
}
