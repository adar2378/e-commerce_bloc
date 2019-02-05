import 'package:flutter/material.dart';

import 'cart_bloc.dart';

class CartProvider extends InheritedWidget {
  final CartBloc cartBloc;
  final Widget child;

  CartProvider({this.cartBloc, this.child}) : super(child: child);

  static CartProvider of(BuildContext context) =>
      context.inheritFromWidgetOfExactType(CartProvider);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }
}
