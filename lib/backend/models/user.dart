class User {
  int? id;
  final String username;
  final String email;
  final String password;
  final String name;
  final String? phone;
  final String? address;
  final bool isNgo;

  User({
    this.id,
    required this.username,
    required this.email,
    required this.password,
    required this.name,
    this.phone,
    this.address,
    required this.isNgo,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'password': password,
      'name': name,
      'phone': phone,
      'address': address,
      'isNgo': isNgo ? 1 : 0,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      username: map['username'],
      email: map['email'],
      password: map['password'],
      name: map['name'],
      phone: map['phone'],
      address: map['address'],
      isNgo: map['isNgo'] == 1,
    );
  }
}
