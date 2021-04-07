import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:shop/custom-widgets/spinner.dart';

typedef ItemWidgetBuilder<T> = Widget Function(
    BuildContext context, T item, int index);

class ListItemsBuilder<T> extends StatefulWidget {
  const ListItemsBuilder(
      {Key key, this.snapshot, this.itemBuilder, this.controller, this.message})
      : super(key: key);
  @required
  final AsyncSnapshot<List<T>> snapshot;
  @required
  final ItemWidgetBuilder<T> itemBuilder;
  final ScrollController controller;
  final String message;

  @override
  _ListItemsBuilderState<T> createState() => _ListItemsBuilderState<T>();
}

class _ListItemsBuilderState<T> extends State<ListItemsBuilder<T>> {
  @override
  Widget build(BuildContext context) {
    if (widget.snapshot.hasData) {
      final List<T> items = widget.snapshot.data;

      if (items.isNotEmpty) {
        return _buildList(items, context, widget.controller);
      } else {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  height: 150,
                  width: 150,
                  child: FlareActor("assets/empty_not_found_404.flr",
                      alignment: Alignment.center,
                      fit: BoxFit.contain,
                      animation: "idle")),
              Text(widget.message ?? 'No data found',
                  style: TextStyle(color: Colors.black54))
            ],
          ),
        );
      }
    } else if (widget.snapshot.hasError) {
      return Center(child: Container(child: Text('Error Loading')));
    }
    return Center(
      child: Spinner(),
    );
  }

  Widget _buildList(List<T> items, BuildContext context,
      [ScrollController controller]) {
    return ListView.builder(
      controller: controller ?? null,
      physics: BouncingScrollPhysics(),
      itemCount: items.length,
      itemBuilder: (context, index) =>
          widget.itemBuilder(context, items[index], index),
    );
  }
}
