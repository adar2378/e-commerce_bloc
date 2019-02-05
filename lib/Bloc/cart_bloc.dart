import 'dart:async';
import 'package:just_like_this/models/cart_item.dart';
import 'package:just_like_this/models/cart.dart';

class CartBloc {
  Cart _cart = Cart();
  final inputController = StreamController<CartItem>.broadcast();
  Sink<CartItem> get cartInputter => inputController.sink;

  final outputController = StreamController<Cart>.broadcast();
  Stream<Cart> get cartOutputter => outputController.stream;

  CartBloc() {
    inputController.stream.listen(onData);
  }

  Cart getCart() {
    return _cart;
  }

  void delete(int index) {
    _cart.deleteItem(index);
    outputController.add(_cart);
  }

  void onData(CartItem event) {
    _cart.addToCart(event);
    outputController.add(_cart);
  }

  void dispose() {
    inputController.close();
    outputController.close();
  }
}
