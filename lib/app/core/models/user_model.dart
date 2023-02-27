import 'dart:convert';

class UserModel {
  String userId = "";
  String email = "";
  String username = "";
  String firstName = "";
  String lastName = "";
  String adress = "";
  String phone = "";
  String fcm = "";
  String profilePic = "";
  UserModel({
    required this.userId,
    required this.email,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.adress,
    required this.phone,
    required this.fcm,
    required this.profilePic,
  });

  factory UserModel.initial() => UserModel(
      email: "",
      username: "",
      lastName: "",
      firstName: "",
      adress: "",
      phone: "",
      fcm: "",
      userId: "",
      profilePic: "");

  UserModel copyWith({
    String? userId,
    String? email,
    String? username,
    String? firstName,
    String? lastName,
    String? adress,
    String? phone,
    String? fcm,
    String? profilePic,
  }) {
    return UserModel(
      userId: userId ?? this.userId,
      email: email ?? this.email,
      username: username ?? this.username,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      adress: adress ?? this.adress,
      phone: phone ?? this.phone,
      fcm: fcm ?? this.fcm,
      profilePic: profilePic ?? this.profilePic,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'userId': userId});
    result.addAll({'email': email});
    result.addAll({'username': username});
    result.addAll({'firstName': firstName});
    result.addAll({'lastName': lastName});
    result.addAll({'adress': adress});
    result.addAll({'phone': phone});
    result.addAll({'fcm': fcm});
    result.addAll({'profilePic': profilePic});

    return result;
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userId: map['userId'] ?? '',
      email: map['email'] ?? '',
      username: map['username'] ?? '',
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'] ?? '',
      adress: map['adress'] ?? '',
      phone: map['phone'] ?? '',
      fcm: map['fcm'] ?? '',
      profilePic: map['profilePic'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(userId: $userId, email: $email, username: $username, firstName: $firstName, lastName: $lastName, adress: $adress, phone: $phone, fcm: $fcm, profilePic: $profilePic)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.userId == userId &&
        other.email == email &&
        other.username == username &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.adress == adress &&
        other.phone == phone &&
        other.fcm == fcm &&
        other.profilePic == profilePic;
  }

  @override
  int get hashCode {
    return userId.hashCode ^
        email.hashCode ^
        username.hashCode ^
        firstName.hashCode ^
        lastName.hashCode ^
        adress.hashCode ^
        phone.hashCode ^
        fcm.hashCode ^
        profilePic.hashCode;
  }
}
