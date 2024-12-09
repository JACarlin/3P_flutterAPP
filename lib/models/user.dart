class User {
  final String id;
  final String email;
  final String name;
  final String address;

  User({
    required this.id,
    required this.email,
    required this.name,
    required this.address,
  });

  // Método para convertir el modelo de usuario a un mapa (para envío en API)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'address': address,
    };
  }

  // Método para crear un objeto de usuario desde un mapa (para recibir desde la API)
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      address: json['address'],
    );
  }
}
