import 'package:flutter/material.dart';
import 'package:just_like_this/models/productList.dart';

class Catalog extends StatefulWidget {
  _CatalogState createState() => _CatalogState();
  final ProductList list;
  final String catagory;
  Catalog(this.list, this.catagory);
}

class _CatalogState extends State<Catalog> {
  ProductList newOne = ProductList.empty();

  void getCatagorizedProducts() {
    for (int i = 0; i < widget.list.getList().length; i++) {
      if (widget.list.getList()[i].catagory == widget.catagory) {
        newOne.list.add(widget.list.getList()[i]);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    getCatagorizedProducts();
    List colors = [Colors.red, Colors.green, Colors.yellow];
    return Scaffold(
      body: Container(
        child: GridView.count(
            crossAxisCount: 2,
            children: List.generate(newOne.getList().length, (index) {
              return Container(
                  color: colors[((index + 1) % 3)],
                  child: Center(child: Text(newOne.getList()[index].name)));
            })),
      ),
    );
  }
}
