class ProductModel {
  final int? id;
  final String name;
  final double price;
  final String description;

  ProductModel({this.id, required this.name, required this.price, required this.description});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'description': description,
    };
  }


  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'],
      name: map['name'],
      price: map['price'],
      description: map['description'],
    );
  }
}
