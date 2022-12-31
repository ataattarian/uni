// ignore_for_file: non_constant_identifier_names

class User {
  int? id;
  String? first_name;
  String? last_name;
  String? email;
  String? password;
  String? access;
  String? refresh;

  void setUser({required String first_name,required String last_name,required String email,required String password}){
    this.first_name=first_name;
    this.last_name=last_name;
    this.email=email;
    this.password=password;
  }

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
        'first_name': first_name,
        'last_name': last_name,
      };

  void fromJsonLogin(
      {required Map<String, dynamic> json,
      required username,
      required password}) {
    access = json['access'];
    refresh = json['refresh'];
    email = username;
    this.password = password;
  }

  void fromJsonSignup(Map<String, dynamic> json) {
    id = json['id'];
    first_name = json['first_name'];
    last_name = json['last_name'];
    email = json['email'];
  }
}
