class Product {
  int id;
  String name;
  String imageLink;
  String description;
  String price;
  double rating;
  bool isLiked;
  String catagory;

  Product(this.id, this.name, this.imageLink, this.description, this.price,
      this.rating, this.isLiked, this.catagory);

  void changeLikeValue() {
    isLiked = !isLiked;
  }
}
