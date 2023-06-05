class UserModel {
  String? uid;
  String? email;
  String? firstName;
  String? secondName;

  UserModel({
    this.uid,
    this.email,
    this.firstName,
    this.secondName,
  });

  // receiving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map?['uid'],
      email: map?['email'],
      firstName: map?['firstName'],
      secondName: map?['secondName'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      if (uid != null) 'uid': uid,
      if (email != null) 'email': email,
      if (firstName != null) 'firstName': firstName,
      if (secondName != null) 'secondName': secondName,
    };
  }
}
