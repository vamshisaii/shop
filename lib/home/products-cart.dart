import 'package:flutter/material.dart';
import 'package:shop/custom-widgets/list-item-builder.dart';
import 'package:shop/home/home-bloc.dart';
import 'package:shop/models/product.model.dart';

import 'widgets/product-tile.dart';

class ProductsCartPage extends StatelessWidget {
  const ProductsCartPage({Key key, @required this.bloc}) : super(key: key);
  final HomeBloc bloc;

  @override
  Widget build(BuildContext context) {
    bloc.loadCartProducts();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          title:
              Padding(padding: const EdgeInsets.all(8.0), child: Text('Cart')),
        ),
        body: StreamBuilder<List<Product>>(
            stream: bloc.cartProductsStream,
            builder: (context, snapshot) => ListItemsBuilder<Product>(
                  snapshot: snapshot,
                  itemBuilder: (context, product, index) =>
                      ProductTile(product: product, bloc: bloc, isCart: true),
                )));
  }
}
