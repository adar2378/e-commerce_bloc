import 'package:just_like_this/models/cart.dart';
import 'package:flutter/material.dart';
import 'package:just_like_this/models/cart.dart';
import 'package:just_like_this/Bloc/cart_bloc.dart';
import 'package:just_like_this/Bloc/cart_provider.dart';

class CartUi extends StatelessWidget {
  Cart cart;
  CartBloc cartBloc;
  CartUi(this.cart, this.cartBloc);

  @override
  Widget build(BuildContext context) {
    return CartProvider(
      cartBloc: cartBloc,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Cart"),
        ),
        body: StreamBuilder<Cart>(
          stream: cartBloc.cartOutputter,
          initialData: cartBloc.getCart(),
          builder: (context, snapshot) {
            if (snapshot.hasData == false ||
                snapshot.data.returnCartList().length == 0) {
              return Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    "assets/tenor.gif",
                    fit: BoxFit.fitWidth,
                  ),
                  Text("No item in the cart!"),
                ],
              ));
            } else {
              return Container(
                height: MediaQuery.of(context).size.height - 56,
                child: Column(
                  children: <Widget>[
                    Container(
                      color: Colors.grey,
                      height: MediaQuery.of(context).size.height -
                          MediaQuery.of(context).size.height / 5,
                      child: ListView.builder(
                        itemCount: snapshot.data.getCartLength(),
                        itemBuilder: (context, index) {
                          return Container(
                            decoration: BoxDecoration(
                              color: index % 2 == 0
                                  ? Colors.green.shade200
                                  : Colors.blue.shade200,
                            ),
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.network(
                                    snapshot
                                        .data.cartList[index].product.imageLink,
                                    height: 80,
                                    width: 120,
                                  ),
                                ),
                                Column(
                                  children: <Widget>[
                                    Text(
                                      snapshot
                                          .data.cartList[index].product.name,
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text("৳ " +
                                        snapshot.data.cartList[index].product
                                            .price),
                                    Text(snapshot.data.cartList[index].count
                                        .toString())
                                  ],
                                ),
                                FlatButton(
                                  child: Icon(Icons.delete),
                                  onPressed: () {
                                    cartBloc.delete(index);
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(12),
                      //height: MediaQuery.of(context).size.height / 5 - 56,
                      child: FittedBox(
                        fit: BoxFit.cover,
                        child: Container(
                          //height: MediaQuery.of(context).size.height / 5 - 80,
                          child: Text(
                              "Total price: ৳ ${snapshot.data.getTotalPrice()}"),
                        ),
                      ),
                    )
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
