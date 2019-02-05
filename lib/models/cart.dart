import 'cart_item.dart';
import 'dart:core';

class Cart {
  List<CartItem> cartList = List<CartItem>();
  int totalItems = 0;

  //Cart();

  List<CartItem> returnCartList() {
    return cartList;
  }

  int getTotalPrice() {
    int total = 0;
    for (int i = 0; i < cartList.length; i++) {
      total =
          total + (cartList[i].count * int.parse(cartList[i].product.price));
    }
    return total;
  }

  int getTotalItems() {
    return totalItems;
  }

  int getCartLength() {
    return cartList.length;
  }

  void deleteItem(int index) {
    totalItems = totalItems - cartList[index].count;
    cartList.removeAt(index);
  }

  void addToCart(CartItem item) {
    bool found = false;
    if (cartList == null || cartList.isEmpty) {
      cartList.add(item);
      totalItems = totalItems + 1;
    } else {
      for (int i = 0; i < cartList.length; i++) {
        if (cartList[i].product.name == item.product.name) {
          cartList[i].count = cartList[i].count + 1;
          found = true;
          totalItems = totalItems + 1;
        }
      }
      if (found == false) {
        cartList.add(item);
        totalItems = totalItems + 1;
      }
    }
  }
}
