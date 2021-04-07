import 'package:flutter/material.dart';
import 'package:shop/home/home-bloc.dart';
import 'package:shop/models/product.model.dart';
import 'package:smart_select/smart_select.dart';

import '../product-view-page.dart';

class ProductTile extends StatefulWidget {
  ProductTile(
      {Key key,
      @required this.product,
      @required this.bloc,
      @required this.isCart})
      : super(key: key);
  final Product product;
  final HomeBloc bloc;
  final bool isCart;

  @override
  _ProductTileState createState() => _ProductTileState();
}

class _ProductTileState extends State<ProductTile> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  ProductViewPage(product: widget.product, bloc: widget.bloc))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  height: 100,
                  width: 100,
                  padding: EdgeInsets.all(8),
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Image.network(
                      widget.product.imageUrl,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(child: Text(widget.product.title)),
                      SizedBox(
                        height: 3,
                      ),
                      Text(
                        widget.product.category,
                        style: TextStyle(color: Colors.black45),
                      ),
                      SizedBox(height: 10),
                      Text("\$" + widget.product.price.toString(),style:TextStyle(fontWeight: FontWeight.bold)),
                      if (widget.isCart)
                        Row(
                          children: [
                            ...widget.product.variants[0]['options']
                                .map((e) => Container(
                                      margin: EdgeInsets.only(right: 8, top: 8),
                                      decoration: BoxDecoration(
                                          color: Colors.grey[100],
                                          border: Border.all(
                                            color: Colors.grey[500],
                                          ),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20))),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(e),
                                      ),
                                    ))
                                .toList()
                          ],
                        )
                    ],
                  ),
                ),
              ),
            ],
          ),
          if (widget.product.variants.isNotEmpty && !widget.isCart)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('View all Variants',
                  style: TextStyle(fontSize: 12, color: Colors.blue)),
            ),
          Divider()
        ],
      ),
    );
  }
}
