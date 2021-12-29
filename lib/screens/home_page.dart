import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yapapp/Widgets/item_card.dart';
import 'package:yapapp/models/items_data.dart';
import 'settings.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SettingsPage()));
            },
          )
        ],
        title: Text('Get It Done'),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  '${Provider.of<ItemData>(context).items.length}',
                  style: Theme.of(context).textTheme.headline3,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 400,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: ListView.builder(
                      reverse: true,
                      shrinkWrap: true,
                      itemCount: Provider.of<ItemData>(context).items.length,
                      itemBuilder: (context, index) => ItemCard(
                        title: Provider.of<ItemData>(context).items[index].title,
                        isDone:
                            Provider.of<ItemData>(context).items[index].isDone,
                        toggleStatus: (bool) {
                          Provider.of<ItemData>(context, listen: false)
                              .toggleStatus(index);
                        },
                        deleteItem: (_) {
                          Provider.of<ItemData>(context, listen: false)
                              .deleteItem(index);
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context, builder: (context) => ItemAdder());
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class ItemAdder extends StatelessWidget {
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              maxLines: 1,
              controller: textController,
              style: TextStyle(color: Colors.black54, fontSize: 20),
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Add Item',
                  hintText: '...'),
              autofocus: true,
            ),
            FlatButton(
                onPressed: () {
                  Provider.of<ItemData>(context, listen: false)
                      .addItem(textController.text);
                  Navigator.pop(context);
                },
                color: Theme.of(context).accentColor,
                child: Text('ADD')),
          ],
        ),
      ),
    );
  }
}

