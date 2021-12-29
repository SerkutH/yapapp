import 'package:flutter/material.dart';


class ItemCard extends StatelessWidget {
  String title;
  bool? isDone;
  final Function(bool?) toggleStatus;
  void Function(DismissDirection) deleteItem ;

  ItemCard({required this.title,this.isDone, required this.toggleStatus, required this.deleteItem});

  @override
  Widget build(BuildContext context) {
    return Dismissible(key: UniqueKey(),
      onDismissed: deleteItem,
      child: Card(
        elevation: 5,
        shadowColor: Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: ListTile(
          title: Text(
            title,
            style: TextStyle(color: Colors.black54),
          ),
          trailing: Checkbox(
            value : isDone,
            onChanged: toggleStatus,
            activeColor: Colors.green,
          ),
        ),
      ),
    );
  }
}
