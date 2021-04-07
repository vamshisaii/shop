import 'dart:async';

import 'package:shop/api-data/data-json.dart';
import 'package:shop/models/product.model.dart';

class HomeBloc {
  List<Product> products = [];
  List<Product> cartProducts = [];
  HomeBloc() {
    loadProducts();
  }

  StreamController<List<Product>> _productsController =
      StreamController<List<Product>>();

  Stream<List<Product>> get productsStream => _productsController.stream;

  StreamController<List<Product>> _cartProductsController =
      StreamController<List<Product>>();

  Stream<List<Product>> get cartProductsStream =>
      _cartProductsController.stream;

  void dispose() {
    _productsController.close();
    _cartProductsController.close();
  }

  void loadProducts() {
    products = productsJson.map((e) => Product.fromJson(e)).toList();

    _productsController.add(products);
  }

  void loadCartProducts() async {
    _cartProductsController.add(cartProducts);
  }

  void reload() {
    products = [];

    loadProducts();
  }
}
