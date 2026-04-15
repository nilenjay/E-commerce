class Product {
  final String name;
  final String image;
  final double price;
  final String description;
  final double rating;

  Product({
    required this.name,
    required this.image,
    required this.price,
    this.description = "",
    this.rating = 4.0,
  });
}
