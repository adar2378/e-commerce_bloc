import 'package:flutter/material.dart';
import 'package:just_like_this/Bloc/cart_bloc.dart';
import 'package:just_like_this/Bloc/search_bloc.dart';
import 'package:just_like_this/Bloc/search_bloc_provider.dart';
import 'package:just_like_this/models/productList.dart';
import 'package:just_like_this/ui/product_details.dart';

class SearchResult extends StatefulWidget {
  @override
  SearchResultState createState() {
    return new SearchResultState();
  }

  final CartBloc cartBloc;
  final ProductList list;

  SearchResult(this.cartBloc, this.list);
}

class SearchResultState extends State<SearchResult> {
  SearchBloc searchBloc;
  @override
  void initState() {
    searchBloc = SearchBloc(widget.list);
    super.initState();
  }

  @override
  void dispose() {
    searchBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SearchProvider(
      searchBloc: searchBloc,
      child: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              floating: true,
              snap: true,
              title: Text("Search App"),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    showSearch(
                      context: context,
                      delegate: CustomSearchDelegate(
                          widget.cartBloc, searchBloc, widget.list),
                    );
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  CartBloc cartBloc;
  SearchBloc searchBloc;
  ProductList list;
  CustomSearchDelegate(this.cartBloc, this.searchBloc, this.list);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    //if (query.length > 0) {
    // print("Was here in result");

    // searchBloc.inputSink.add(query);
    // searchBloc.outputStream.last.then((onValue) {
    //   print("Printing name" + onValue.getList().last.name);
    // });

    // return StreamBuilder<ProductList>(
    //   stream: searchBloc.outputStream,
    //   initialData: ProductList.empty(),
    //   builder: (context, snapshot) {
    //     if (snapshot.data.getList().length == 0) {
    //       return Center(
    //           child: Container(
    //         child: Text("No match found!"),
    //       ));
    //     } else if (snapshot.connectionState == ConnectionState.waiting) {
    //       return Center(
    //           child: Container(
    //         child: CircularProgressIndicator(),
    //       ));
    //     } else {
    //       return ListView.separated(
    //         itemCount: snapshot.data.getList().length,
    //         itemBuilder: (context, index) {
    //           return Container(
    //             margin: EdgeInsets.all(8),
    //             child: GestureDetector(
    //               onTap: () {
    //                 Navigator.push(
    //                   context,
    //                   MaterialPageRoute(
    //                       builder: (context) => ProductDetails(
    //                           snapshot.data.getList()[index], cartBloc)),
    //                 );
    //               },
    //               child: Container(
    //                   decoration: BoxDecoration(
    //                     // boxShadow: [boxShadow],
    //                     // borderRadius: borderRadius,
    //                     color: index % 2 == 0
    //                         ? Colors.blue.shade100
    //                         : Colors.blue.shade300,
    //                   ),
    //                   alignment: Alignment.center,
    //                   height: 30,
    //                   child: Text(snapshot.data.getList()[index].name)),
    //             ),
    //           );
    //         },
    //         separatorBuilder: (BuildContext context, int index) {
    //           return Divider(
    //             color: Colors.black,
    //           );
    //         },
    //       );
    //     }
    //   },
    // );
    //}
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    searchBloc.inputSink.add(query);
    searchBloc.outputStream.last.then((onValue) {
      print("Printing name" + onValue.getList().last.name);
    });

    return StreamBuilder<ProductList>(
      stream: searchBloc.outputStream,
      initialData: ProductList.empty(),
      builder: (context, snapshot) {
        if (query.length == 0) {
          return Center(
              child: Container(
            child: Text(
                "Write the product name you want to find in the search bar!"),
          ));
        } else if (snapshot.data.getList().length == 0) {
          return Center(
              child: Container(
            child: Text("No match found!"),
          ));
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child: Container(
            child: CircularProgressIndicator(),
          ));
        } else {
          return ListView.separated(
            itemCount: snapshot.data.getList().length,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.all(8),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProductDetails(
                              snapshot.data.getList()[index], cartBloc, list)),
                    );
                  },
                  child: Container(
                      decoration: BoxDecoration(
                        // boxShadow: [boxShadow],
                        // borderRadius: borderRadius,
                        color: index % 2 == 0
                            ? Colors.blue.shade100
                            : Colors.blue.shade300,
                      ),
                      alignment: Alignment.center,
                      height: 30,
                      child: Text(snapshot.data.getList()[index].name)),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return Divider(
                color: Colors.black,
              );
            },
          );
        }
      },
    );
  }
}
