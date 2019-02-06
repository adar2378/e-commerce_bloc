import 'product.dart';

class ProductList {
  List<Product> list;
  ProductList(this.list);

  ProductList.empty() {
    list = List<Product>();
  }

  List<Product> getList() {
    return list;
  }
}
