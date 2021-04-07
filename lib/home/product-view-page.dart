import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop/custom-widgets/spinner.dart';
import 'package:shop/home/home-bloc.dart';
import 'package:shop/home/products-cart.dart';
import 'package:shop/models/option.model.dart';
import 'package:shop/models/product.model.dart';
import 'package:smart_select/smart_select.dart';
import 'package:collection/collection.dart';

Function unOrdDeepEq = const DeepCollectionEquality.unordered().equals;

class ProductViewPage extends StatefulWidget {
  ProductViewPage({Key key, @required this.product, @required this.bloc})
      : super(key: key);
  final Product product;
  final HomeBloc bloc;

  @override
  _ProductViewPageState createState() => _ProductViewPageState();
}

class _ProductViewPageState extends State<ProductViewPage> {
  Product selectedProduct;
  Product product;

  @override
  void initState() {
    super.initState();
    product = widget.product;
    selectedProduct = Product(
        id: product.id,
        title: product.title,
        options: [],
        variants: [],
        imageUrl: product.imageUrl,
        category: product.category,
        description: product.description,
        price: product.price);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          actions: [
            IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ProductsCartPage(bloc: widget.bloc)));
              },
            )
          ],
        ),
        body: Stack(children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 500,
                      width: size.width,
                      child: Image.network(
                        product.imageUrl,
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent loadingProgress) {
                          if (loadingProgress == null)
                            return FittedBox(fit: BoxFit.contain, child: child);
                          return Center(
                            child: Spinner(),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(product.title, style: TextStyle(fontSize: 15)),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Text('\$' + selectedProduct.price.toString(),
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                ),
                SizedBox(height: 10),
                ...product.options.map((e) => SmartSelect.single(
                    modalFilter: true,
                    modalType: S2ModalType.bottomSheet,
                    title: e.name,
                    choiceItems: e.values
                        .map((e) => S2Choice<String>(value: e, title: e))
                        .toList(),
                    value: '',
                    onChange: (state) {
                      selectedProduct.options.add(Option(
                          id: e.id, name: e.name, values: [state.value]));
                    })),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Description: ',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                Container(
                    width: size.width,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(product.description,
                          style: TextStyle(color: Colors.black45)),
                    )),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 8.0,
                  ),
                  child: Row(
                    children: [
                      Text(
                        'Category: ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(product.category)
                    ],
                  ),
                ),
                SizedBox(height: 50),
              ],
            ),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: InkWell(
                onTap: () {
                  if (selectedProduct.options.length ==
                      product.options.length) {
                    var variant = product.variants.firstWhere(
                        (element) =>
                            element['options'].join('') ==
                            selectedProduct.options
                                .map((e) => e.values[0])
                                .toList()
                                .join(''),
                        orElse: () => null);
                    if (variant.isNotEmpty) {
                      selectedProduct.variants = [variant];
                      setState(() {
                        selectedProduct.price =
                            selectedProduct.variants[0]['price'];
                            print(selectedProduct.toJson());
                      });
                      widget.bloc.cartProducts.add(selectedProduct);
                      Fluttertoast.showToast(
                          msg: "Added to cart",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.grey[600],
                          textColor: Colors.white,
                          fontSize: 16.0);
                    } else
                      Fluttertoast.showToast(
                          msg: "Variant not Found",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.grey[600],
                          textColor: Colors.white,
                          fontSize: 16.0);
                    // product.variants.firstWhere((variant) => selectedProduct
                    //     .options
                    //     .map((selectedVariant) {if(variant['option${selectedVariant.id}'])})
                    //     .toList()
                    //     .reduce((value, element) => value && element));

                  } else
                    Fluttertoast.showToast(
                        msg: "Select a variant",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.grey[600],
                        textColor: Colors.white,
                        fontSize: 16.0);
                },
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: Colors.orange,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 1.0), //(x,y)
                          blurRadius: 6.0,
                        ),
                      ],
                    ),
                    width: size.width,
                    height: 40,
                    child: Center(child: Text('ADD'))),
              ))
        ]));
  }
}
