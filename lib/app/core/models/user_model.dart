class UserModel {
  int? id;
  String email;
  String username;
  String firstName;
  String lastName;
  String adress;
  String phone;
  // bool isVoteAdmin = false;
  // bool isVerified = false;
  // bool isActive = false;

  UserModel({
    this.id = -1,
    required this.email,
    required this.username,
    required this.lastName,
    required this.firstName,
    required this.adress,
    required this.phone,
    // this.isActive = true,
    // this.isVerified = false,
    // this.isVoteAdmin = false,
  });

  factory UserModel.initial() => UserModel(
      email: "",
      username: "",
      lastName: "",
      firstName: "",
      adress: "",
      phone: "");

  factory UserModel.fromMap(Map<String, dynamic> jsonData) {
    return UserModel(
      username: jsonData['username'],
      email: jsonData['email'],
      lastName: jsonData['last_name'],
      firstName: jsonData['first_name'],
      adress: jsonData['address'],
      phone: jsonData['phone'],
      // isActive: jsonData['is_active'],
      // isVerified: jsonData['is_verified'],
      // isVoteAdmin: jsonData['is_vote_admin'],
    );
  }
// {
//   "username": "ferdi",
//   "first_name": "string",
//   "last_name": "string",
//   "address": "string",
//   "phone": "string",
//   "email": "hernandezdecos96@gmail.com"
// }

//Recuperer la liste totale des utilisateurs
  static List<UserModel> tolist(List jsonData) {
    List<UserModel> users = [];
    for (dynamic data in jsonData) {
      users.add(UserModel.fromMap(data));
    }
    return users;
  }

// Traduire les donnée de l'utilisateur en Map
  Map<String, String> toMap() {
    Map<String, String> map = {
      "username": username,
      "last_name": lastName,
      "first_name": firstName,
      "address": adress,
      "phone": phone,
      "email": email,
      // "is_active": isActive.toString(),
      // "is_verified": isVerified.toString(),
      // "is_vote_admin": isVoteAdmin.toString(),
    };
    return map;
  }

  static List topMapList(List<UserModel> data) {
    List mapList = [];
    for (UserModel d in data) {
      mapList.add(d.toMap());
    }

    return mapList;
  }

  static UserModel get defaultValue {
    return UserModel(
        adress: '',
        firstName: '',
        lastName: '',
        phone: '',
        username: '',
        email: '');
  }
}
