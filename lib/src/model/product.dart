class Product {
  int id;
  String name;
  String category;
  String image;
  double price;
  bool isLiked;
  bool isSelected;
  Product(
      {this.id,
      this.name,
      this.price,
      this.category,
      this.isLiked,
      this.isSelected = false,
      this.image});
}
