class User {
  User({required this.user_id, required this.username, required this.email});
  String user_id;
  String username;
  String email;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        user_id: json['_id'], username: json["username"], email: json['email']);
  }
}
