class  User {
  late String id;
  late final String username;
  late final String password;

  User({required this.id, required this.username, required this.password});


  Map <String, dynamic> toJson() => {
    'id': id,
    'username': username,
    'password': password
  };

  static User fromJson(Map<String, dynamic> json) => User(
    id: json['id'],
    username: json['username'],
    password: json['password']
  );
}