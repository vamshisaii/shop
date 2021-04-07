import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/custom-widgets/decoration.dart';
import 'package:shop/custom-widgets/list-item-builder.dart';
import 'package:shop/home/home-bloc.dart';
import 'package:shop/home/products-cart.dart';
import 'package:shop/models/product.model.dart';

import 'widgets/product-tile.dart';

class HomePage extends StatelessWidget {
  HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<HomeBloc>(context, listen: false);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          title:
              Padding(padding: const EdgeInsets.all(8.0), child: Text('Shop')),
          actions: [
            IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProductsCartPage(bloc: bloc)));
                })
          ],
        ),
        body: StreamBuilder<List<Product>>(
            stream: bloc.productsStream,
            builder: (context, snapshot) => ListItemsBuilder<Product>(
                  snapshot: snapshot,
                  itemBuilder: (context, product, index) =>
                      ProductTile(product: product, bloc: bloc, isCart: false),
                )));
  }
}
