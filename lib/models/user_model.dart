class User {
  final String name;
  final String email;
  final String password;

  User({required this.name, required this.email, required this.password});

  // Fungsi untuk mengonversi data menjadi format JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
    };
  }

  // Fungsi untuk mengonversi JSON menjadi objek User
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      email: json['email'],
      password: json['password'],
    );
  }
}
