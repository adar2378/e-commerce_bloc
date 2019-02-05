import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:just_like_this/Bloc/cart_bloc.dart';
import 'package:just_like_this/Bloc/likeBloc.dart';
import 'package:just_like_this/models/productList.dart';
import 'package:just_like_this/models/product.dart';
import 'product_details.dart';
import 'package:just_like_this/Bloc/cart_provider.dart';
import 'package:just_like_this/Bloc/bloc_provider.dart';
import 'cart_ui.dart';
import 'package:just_like_this/models/cart.dart';

class Menu extends StatefulWidget {
  _MenuState createState() => _MenuState();
}

ProductList myList;

class _MenuState extends State<Menu> {
  void initState() {
    super.initState();

    List<Product> list = [
      Product(2, "Hat", "https://via.placeholder.com/300", "This is a hat",
          "100", 4, true),
      Product(2, "Bat", "https://via.placeholder.com/300", "This is a Bat",
          "120", 4.5, true),
      Product(2, "Shoe", "https://via.placeholder.com/300", "This is a Shoe",
          "200", 4.6, true),
      Product(2, "Toy", "https://via.placeholder.com/300", "This is a Toy",
          "170", 4.1, true),
      Product(2, "Cow", "https://via.placeholder.com/300", "This is a Cow",
          "90", 4, true),
      Product(2, "Bat", "https://via.placeholder.com/300", "This is a Bat",
          "500", 4.8, true),
      Product(2, "fat", "https://via.placeholder.com/300", "This is a fat",
          "500", 4.8, true),
      Product(2, "Sad", "https://via.placeholder.com/300", "This is a Sad",
          "500", 4.8, true),
      Product(2, "Mad", "https://via.placeholder.com/300", "This is a Mad",
          "500", 4.8, true),
    ];
    myList = new ProductList(list);
  }

  LikeBloc likeBloc = LikeBloc();
  CartBloc cartBloc = CartBloc();

  @override
  void dispose() {
    likeBloc.dispose();
    cartBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CartProvider(
      cartBloc: cartBloc,
      child: Scaffold(
        drawer: Drawer(
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the Drawer if there isn't enough vertical
          // space to fit everything.
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    CircleAvatar(
                        radius: 22,
                        backgroundColor: Colors.white,
                        child: Icon(Icons.person_outline)),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      "Login / Register",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    )
                  ],
                ),
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
              ),
              ExpansionTile(
                leading: Icon(Icons.computer),
                title: Text('Computer'),
                children: <Widget>[
                  ExpansionTile(
                    leading: Container(
                      height: 10,
                      width: 10,
                    ),
                    title: Text('Gaming & Console'),
                    children: <Widget>[
                      ListTile(
                        leading: Container(
                          height: 10,
                          width: 10,
                        ),
                        title: Text('Xbox'),
                      ),
                      ListTile(
                        leading: Container(
                          height: 10,
                          width: 10,
                        ),
                        title: Text('PlayStation'),
                      ),
                      ListTile(
                        leading: Container(
                          height: 10,
                          width: 10,
                        ),
                        title: Text('Controller'),
                      ),
                    ],
                  ),
                ],
              ),
              ExpansionTile(
                leading: Icon(Icons.phone_android),
                title: Text('Electronics & Appliances'),
                children: <Widget>[
                  ExpansionTile(
                    leading: Container(
                      height: 10,
                      width: 10,
                    ),
                    title: Text('Home Appliances'),
                    children: <Widget>[
                      ListTile(
                        leading: Container(
                          height: 10,
                          width: 10,
                        ),
                        title: Text('Air Conditioner'),
                      ),
                      ListTile(
                        leading: Container(
                          height: 10,
                          width: 10,
                        ),
                        title: Text('Air Cooler'),
                      ),
                      ListTile(
                        leading: Container(
                          height: 10,
                          width: 10,
                        ),
                        title: Text('Washing Machine'),
                      ),
                    ],
                  ),
                ],
              ),
              ExpansionTile(
                leading: Icon(Icons.motorcycle),
                title: Text('Autos & Vehicles'),
                children: <Widget>[
                  ExpansionTile(
                    leading: Container(
                      height: 10,
                      width: 10,
                    ),
                    title: Text('Vehicle Parts'),
                    children: <Widget>[
                      ListTile(
                        leading: Container(
                          height: 10,
                          width: 10,
                        ),
                        title: Text('Helmet'),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              pinned: true,
              floating: false,
              expandedHeight: 120.0,
              title: Text("Pickaboo"),
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  alignment: Alignment.bottomCenter,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                      ),
                      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                      // height: 60,

                      // padding: ,
                      child: TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.all(16),
                          hintText: "Search Your Product",
                          prefixIcon: Container(
                              margin: EdgeInsets.fromLTRB(10, 8, 6, 8),
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(35)),
                              child: Icon(
                                Icons.search,
                                color: Colors.white,
                              )),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              CartUi(cartBloc.getCart(), cartBloc)),
                    );
                  },
                  icon: StreamBuilder<Cart>(
                    stream: cartBloc.cartOutputter,
                    //initialData: 0,
                    initialData: cartBloc.getCart(),
                    builder: (context, snapshot) {
                      var text = "";
                      if (snapshot.hasData) {
                        text = snapshot.data.getTotalItems().toString();
                      }
                      return Stack(
                        alignment: Alignment.topRight,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: Icon(Icons.shopping_cart),
                          ),
                          Container(
                            width: 18,
                            height: 18,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                border:
                                    Border.all(color: Colors.black, width: 1),
                                color: Colors.green.withOpacity(.7)),
                            child: Center(
                              child: Text(text == "0" ? "" : text,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12)),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.more_vert),
                  color: Colors.white,
                )
              ],
            ),
            SliverToBoxAdapter(
              child: Container(
                height: 200,
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Swiper(
                  itemBuilder: (BuildContext context, int index) {
                    return new Image.network(
                      "http://via.placeholder.com/288x188",
                      fit: BoxFit.fill,
                    );
                  },
                  itemCount: 10,
                  viewportFraction: 0.85,
                  scale: 0.9,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Promotions",
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      "14 items",
                      style: TextStyle(color: Colors.black54),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                height: 86,
                child: ListView.builder(
                  itemCount: 8,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Center(
                      child: Container(
                        height: 80,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.white, Colors.blue],
                        )),
                        width: 80,
                        child: Center(child: Text("Contents $index")),
                        margin: EdgeInsets.all(4),
                      ),
                    );
                  },
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Featured Products",
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
            SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, crossAxisSpacing: 8, mainAxisSpacing: 8),
                delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      print("tapped");
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductDetails(
                                myList.getList()[index], cartBloc)),
                      );
                    },
                    child: new Container(
                        child: Stack(
                          alignment: Alignment.topCenter,
                          children: <Widget>[
                            Image.network(myList.getList()[index].imageLink),
                            Text(
                              myList.getList()[index].name,
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                        height: 150.0),
                  );
                }, childCount: myList.getList().length))
          ],
        ),
      ),
    );
  }
}
