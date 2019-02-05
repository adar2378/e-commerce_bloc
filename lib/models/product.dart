class Product {
  int id;
  String name;
  String imageLink;
  String description;
  String price;
  double rating;
  bool isLiked;

  Product(this.id, this.name, this.imageLink, this.description, this.price,
      this.rating, this.isLiked);

  void changeLikeValue() {
    isLiked = !isLiked;
  }
}
