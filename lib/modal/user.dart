

class User {

  User({
    this.username,
    this.password,
    this.email,
    this.id,
  });

  String? username;
  String? password;
  String? email;
  int? id;

  factory User.fromMap(Map<String, dynamic> json) => User(
    username: json["username"],
    password: json["password"],
    email: json["email"],
    id:  json["id"],
  );

  Map<String, dynamic> toMap() => {
    "username": username,
    "password": password,
    "email": email,
    "id" : id,
  };
}
