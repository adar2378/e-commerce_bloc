import 'package:just_like_this/models/cart.dart';
import 'package:flutter/material.dart';
import 'package:just_like_this/Bloc/cart_bloc.dart';
import 'package:just_like_this/Bloc/cart_provider.dart';

class CartUi extends StatelessWidget {
  final Cart cart;
  final CartBloc cartBloc;
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      color: Colors.white,
                      height: MediaQuery.of(context).size.height -
                          MediaQuery.of(context).size.height / 5-34,
                      child: ListView.builder(
                        itemCount: snapshot.data.getCartLength(),
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
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
                                    fit: BoxFit.fill,
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
                                    Row(
                                      children: <Widget>[
                                        IconButton(
                                          onPressed: () {
                                            cartBloc.changeCount(index, true);
                                          },
                                          icon: Icon(Icons.add_circle_outline),
                                        ),
                                        Text(snapshot.data.cartList[index].count
                                            .toString()),
                                        IconButton(
                                          onPressed: () {
                                            if (snapshot
                                                    .data.cartList[index].count
                                                    .toString() !=
                                                "1") {
                                              cartBloc.changeCount(
                                                  index, false);
                                            } else {
                                              Scaffold.of(context)
                                                  .showSnackBar(SnackBar(
                                                duration: Duration(seconds: 1),
                                                content: Text(
                                                    "You must keep one item"),
                                              ));
                                            }
                                          },
                                          icon:
                                              Icon(Icons.remove_circle_outline),
                                        ),
                                      ],
                                    )
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                              "Sub-total: ৳ ${snapshot.data.getTotalPrice()}")),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                      // height: MediaQuery.of(context).size.height / 5,
                      child: Row(
                        children: <Widget>[
                          Container(
                            color: Colors.yellow.shade300,
                            width: MediaQuery.of(context).size.width / 2,
                            height: 55,
                            child: FlatButton(
                              onPressed: () {},
                              child: Text(
                                  "Total price: ৳ ${snapshot.data.getTotalPrice()}"),
                            ),
                          ),
                          Container(
                            color: Colors.yellow.shade900,
                            width: MediaQuery.of(context).size.width / 2,
                            height: 55,
                            child: FlatButton(
                              onPressed: () {},
                              child:
                                  Text("Buy(${snapshot.data.getTotalItems()})"),
                            ),
                          ),
                        ],
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
