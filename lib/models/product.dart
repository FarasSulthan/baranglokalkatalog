class Product {
  final String name;
  final double price;
  final String description;

  Product({
    required this.name,
    required this.price,
    required this.description,
  });

  // Untuk menyimpan produk dalam format Map, agar bisa disimpan ke SharedPreferences
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
      'description': description,
    };
  }

  // Membaca produk dari format Map
  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      name: map['name'],
      price: map['price'],
      description: map['description'],
    );
  }
}