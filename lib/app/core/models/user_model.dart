

class UserModel{
  int ? id;
  String email;
  String username; 
  String firstName;
  String lastName; 
  String adress;
  String phone;
  bool isAdmin;
  bool isVoteAdmin; 
  bool isVerified;
  bool isActive; 
  bool isStaff; 
  String createdAt; 
  String updateAt;
  String password;


   UserModel({
    this.id=-1,
    required this.email,
    required this.username,
    required this.lastName,
    required this.firstName,
    required this.adress, 
    required this.phone,
    required this.password, 
    this.createdAt='',
    this.updateAt='',
    this.isAdmin=false, 
    this.isActive=true,
    this.isStaff=false, 
    this.isVerified=false, 
    this.isVoteAdmin=false,


   }); 

factory UserModel.fromMap(Map<String,dynamic> jsonData){
  return UserModel(
    username:jsonData['username'] ,
    email: jsonData['email'], 
    lastName: jsonData['last_name'], 
    firstName: jsonData['first_name'], 
    adress: jsonData['address'], 
    phone: jsonData['phone'], 
    password:jsonData['password'], 
    isActive: jsonData['is_active'], 
    isAdmin:jsonData['is_admin'], 
    isStaff: jsonData['is_staff'], 
    isVerified: jsonData['is_verified'], 
    isVoteAdmin: jsonData['is_vote_admin'], 
    createdAt: jsonData['created_at'], 
    updateAt: jsonData['updated_at']
     );
}

//Recuperer la liste totale des utilisateurs 
static List<UserModel> tolist(List jsonData){
  List<UserModel>users=[];
  for (dynamic data in jsonData){
    users.add(UserModel.fromMap(data));
  }
  return users;
}

// Traduire les donnée de l'utilisateur en Map 
Map<String,String> toMap(){
  Map<String,String>map={
    "username":username, 
    "last_name":lastName, 
    "first_name":firstName,
    "address":adress, 
    "phone":phone,
    "email":email, 
    "password":password, 
    "is_active":isActive.toString(), 
    "is_admin":isAdmin.toString(), 
    "is_staff":isStaff.toString(), 
    "is_verified":isVerified.toString(), 
    "is_vote_admin":isVoteAdmin.toString(), 
    "created_at":createdAt,
    "updated_at":updateAt
  };
  return map;
}

static List topMapList(List<UserModel> data){
   List mapList = [];
    for (UserModel d in data) {
      mapList.add(d.toMap());
    }

    return mapList;
}
static UserModel get defaultValue {
    return UserModel(adress: '', firstName: '', lastName: '', password: '', phone: '', username: '', email: ''
        );
  }

}