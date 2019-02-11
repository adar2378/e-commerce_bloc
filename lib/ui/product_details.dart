import 'package:flutter/material.dart';
import 'package:just_like_this/models/product.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:just_like_this/ui/search_results.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:just_like_this/Bloc/likeBloc.dart';
import 'package:just_like_this/Bloc/bloc_provider.dart';
import 'package:just_like_this/Bloc/cart_bloc.dart';
import 'package:just_like_this/models/cart.dart';
import 'package:just_like_this/models/cart_item.dart';
import 'cart_ui.dart';
import 'package:just_like_this/models/productList.dart';

class ProductDetails extends StatefulWidget {
  final Product product;
  final CartBloc cartBloc;
  final ProductList productList;
  ProductDetails(this.product, this.cartBloc, this.productList);

  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation<double> animation;
  Cart cart;
  double scale;
  LikeBloc likeBloc;
  void initState() {
    cart = Cart();

    likeBloc = LikeBloc();
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    animation =
        CurvedAnimation(parent: animationController, curve: Curves.bounceInOut);

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animationController.reverse();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  static final _scaleTween = Tween<double>(begin: 1.0, end: 1.5);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      likeBloc: likeBloc,
      child: Scaffold(
        backgroundColor: Colors.grey.shade50,
        body: Column(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height -
                  (MediaQuery.of(context).size.height / 2) / 8 +
                  2,
              child: CustomScrollView(
                slivers: <Widget>[
                  SliverAppBar(
                    pinned: true,
                    backgroundColor: Colors.blue.shade200,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Stack(
                        alignment: Alignment.bottomRight,
                        children: <Widget>[
                          Swiper(
                            itemBuilder: (BuildContext context, int index) {
                              return new Image.network(
                                widget.product.imageLink,
                                fit: BoxFit.fill,
                              );
                            },
                            itemCount: 3,
                            pagination: new SwiperPagination(
                                alignment: Alignment.bottomLeft),
                            //control: new SwiperControl(),
                          ),
                          Positioned(
                              right: 10,
                              bottom: 10,
                              child: StreamBuilder(
                                  stream: likeBloc.outStream,
                                  initialData: widget.product.isLiked,
                                  builder: (context, snapshot) {
                                    return IconButton(
                                      icon: (snapshot.data == true
                                          ? Icon(
                                              Icons.favorite,
                                              color: Colors.red,
                                            )
                                          : Icon(
                                              Icons.favorite_border,
                                              color: Colors.white,
                                            )),
                                      iconSize: 24,
                                      onPressed: () {
                                        likeBloc.inputController
                                            .add(widget.product);

                                        //putting the product in the input stream
                                      },
                                    );
                                  }))
                        ],
                      ),
                    ),
                    expandedHeight: MediaQuery.of(context).size.height / 2,
                    actions: <Widget>[
                      IconButton(
                        icon: Icon(Icons.search),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SearchResult(
                                    widget.cartBloc, widget.productList)),
                          );
                        },
                      ),
                      IconButton(
                        icon: StreamBuilder<Cart>(
                          initialData: widget.cartBloc.getCart(),
                          stream: widget.cartBloc.cartOutputter,
                          builder: (context, snapshot) {
                            var text = "";
                            print("Printing " +
                                snapshot.data.getTotalItems().toString());
                            if (snapshot.hasData) {
                              text = snapshot.data.getTotalItems().toString();
                            }
                            return Stack(
                              alignment: Alignment.topRight,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(top: 4.0),
                                  child: Icon(
                                    Icons.shopping_cart,
                                    color: text == "0"
                                        ? Colors.white
                                        : Colors.blue,
                                    size: 26,
                                  ),
                                ),
                                AnimatedBuilder(
                                  animation: animation,
                                  builder: (context, child) {
                                    return Transform.scale(
                                      scale: _scaleTween.evaluate(animation),
                                      child: child,
                                    );
                                  },
                                  child: Container(
                                    width: 18,
                                    height: 18,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25),
                                        border: Border.all(
                                            color: Colors.black, width: 1),
                                        color: Colors.green.withOpacity(.7)),
                                    child: Center(
                                      child: Text(text == "0" ? "" : text,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12)),
                                    ),
                                  ),
                                )
                              ],
                            );
                          },
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CartUi(
                                    widget.cartBloc.getCart(),
                                    widget.cartBloc)),
                          );
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.more_vert),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.all(0),
                      child: Stack(children: [
                        Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Card(
                                elevation: .2,
                                color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 16.0),
                                        child: Text(
                                          widget.product.name,
                                          style: TextStyle(
                                              fontSize: 20,
                                              color:
                                                  Colors.black.withOpacity(.7)),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 4.0),
                                        child: Divider(
                                          color: Colors.black26,
                                          height: .1,
                                          indent: 4,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 20.0, horizontal: 2),
                                        child: Row(
                                          children: <Widget>[
                                            SmoothStarRating(
                                              allowHalfRating: true,
                                              starCount: 5,
                                              rating: 4.4,
                                              size: 20.0,
                                              color: Colors.yellow.shade800,
                                              //borderColor: Colors.green,
                                            ),
                                            Spacer(
                                              flex: 1,
                                            ),
                                            Text(widget.product.rating
                                                .toString()),
                                            Spacer(
                                              flex: 1,
                                            ),
                                            Container(
                                                padding: EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                    color:
                                                        Colors.yellow.shade100),
                                                child: Text(
                                                  "-41%",
                                                  style: TextStyle(
                                                      color: Colors
                                                          .yellow.shade800),
                                                )),
                                            Spacer(
                                              flex: 2,
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  "৳ ${widget.product.price}",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  "৳ 1500",
                                                  style: TextStyle(
                                                      color: Colors.black54,
                                                      fontSize: 12,
                                                      decoration: TextDecoration
                                                          .lineThrough),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 4.0),
                                        child: Divider(
                                          color: Colors.black26,
                                          height: .1,
                                          indent: 4,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 16),
                                        child: Icon(Icons.directions_car),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 4.0),
                                        child: Divider(
                                          color: Colors.black26,
                                          height: .1,
                                          indent: 4,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 16),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Container(
                                              width: 130,
                                              decoration: BoxDecoration(
                                                  color: Colors.cyan.shade200,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          25)),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 8.0,
                                                        horizontal: 12),
                                                child: Text(
                                                  "3 Days Easy\nReturn",
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Container(
                                              width: 130,
                                              decoration: BoxDecoration(
                                                  color: Colors
                                                      .indigoAccent.shade200,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          25)),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 8.0,
                                                        horizontal: 12),
                                                child: Text(
                                                  "Product Lifetime\nWarranty",
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            ExpansionTile(
                              title: Text(
                                "Description",
                                style: TextStyle(color: Colors.black),
                              ),
                              children: <Widget>[
                                Container(
                                  child: Text(widget.product.description),
                                )
                              ],
                            ),
                          ],
                        ),
                      ]),
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: (MediaQuery.of(context).size.height / 2) / 8 - 2,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Expanded(
                    flex: 4,
                    child: Container(
                      width: MediaQuery.of(context).size.width / 3,
                      height: (MediaQuery.of(context).size.height / 2) / 8 - 2,
                      child: RaisedButton(
                        color: Colors.yellow.shade900,
                        onPressed: () {},
                        child: FittedBox(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.shopping_cart,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Buy Now",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Container(
                      width: MediaQuery.of(context).size.width / 3,
                      height: (MediaQuery.of(context).size.height / 2) / 8 - 2,
                      child: RaisedButton(
                        color: Colors.blue.shade600,
                        onPressed: () {
                          widget.cartBloc.cartInputter
                              .add(CartItem(widget.product));

                          setState(() {
                            animationController.forward();
                          });
                        },
                        child: FittedBox(
                          child: Text(
                            "Add to Cart",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: FittedBox(
                      fit: BoxFit.cover,
                      child: Container(
                        height:
                            (MediaQuery.of(context).size.height / 2) / 8 - 2,
                        child: RaisedButton(
                          color: Colors.blue.shade200,
                          onPressed: () {},
                          child: Text(
                            "Share",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
