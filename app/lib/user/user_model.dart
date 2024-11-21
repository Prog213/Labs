class User {
  final int id;
  final String email;
  late String bio;
  late String address;
  final String token;
  late List<Tea> teas;

  User({
    required this.id,
    required this.email,
    required this.bio,
    required this.address,
    required this.token,
    required this.teas,
  });

  // Factory method to create a User instance from JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      email: json['email'] as String,
      bio: json['bio'] as String,
      address: json['address'] as String,
      token: json['token'] as String,
      teas: (json['teas'] as List<dynamic>)
          .map((teaJson) => Tea.fromJson(teaJson as Map<String, dynamic>))
          .toList(),
    );
  }

  // Method to convert a User instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'bio': bio,
      'address': address,
      'token': token,
      'teas': teas.map((tea) => tea.toJson()).toList(),
    };
  }
}

class Tea {
  final String name;
  final double price;

  Tea({
    required this.name,
    required this.price,
  });

  // Factory method to create a Tea instance from JSON
  factory Tea.fromJson(Map<String, dynamic> json) {
    return Tea(
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
    );
  }

  // Method to convert a Tea instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'price': price,
    };
  }
}
