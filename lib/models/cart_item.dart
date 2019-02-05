import 'product.dart';

class CartItem {
  int count = 1;
  Product product;

  CartItem(this.product);

  @override
  String toString() => "${product.name} ✕ $count";
}
