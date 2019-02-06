import 'dart:async';

import 'package:just_like_this/models/productList.dart';

class SearchBloc {
  ProductList list;
  StreamController<String> inputController = StreamController<String>();
  Sink<String> get inputSink => inputController.sink;
  StreamController<ProductList> outputController =
      StreamController<ProductList>();

  Stream<ProductList> get outputStream => outputController.stream;

  SearchBloc(ProductList myList) {
    list = myList;
    inputController.stream.listen(onData);
  }

  void onData(String query) {
    ProductList newList = ProductList.empty();
    if (query.isEmpty) {
      outputController.add(newList);
    } else {
      for (int i = 0; i < list.getList().length; i++) {
        if (list
            .getList()[i]
            .name
            .toLowerCase()
            .contains(query.toLowerCase())) {
          newList.list.add(list.getList()[i]);
          print("Inside searching: $query");
        }
      }
      outputController.add(newList);
    }
  }

  void dispose() {
    inputController.close();
    outputController.close();
  }
}
