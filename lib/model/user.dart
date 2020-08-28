class User {
  int id;
  String userName;
  String email;
  // String token;

  User({
    this.id,
    this.userName,
    this.email,
    // this.token,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['username'];
    email = json['email'];
    // token = json['auth_key'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.userName;
    data['email'] = this.email;
    // data['auth_key'] = this.token;
    return data;
  }
}
