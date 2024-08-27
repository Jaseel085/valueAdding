class UserModel{
   String name;
   String email;
   String password;
   String uid;
   int value;


   UserModel({
    required this.name,
    required this.email,
    required this.password,
    required this.uid,
    required this.value,

  });
  UserModel copyWith({
    String? name,
    String? email,
    String? password,
    String? uid,
    int? value,

  }) {
    return UserModel(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      uid: uid ?? this.uid,
      value: value ?? this.value,

    );
  }


  Map<String, dynamic> toMap() {
    return {
      'name': this.name,
      'email': this.email,
      'password': this.password,
      'uid': this.uid,
      'value': this.value,

    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'],
      email: map['email'] ,
      password: map['password'] ,
      uid: map['uid'] ,
      value: map['value'] ,

    );
  }
}