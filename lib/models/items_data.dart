import 'dart:collection';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './item.dart';


class ItemData with ChangeNotifier {
  late final List<Item> _items = [

  ];

  static SharedPreferences? _sharedPref;

  void toggleStatus(int index) {
    _items[index].toggleStatus();
    saveItemsToSharedPref(_items);
    notifyListeners();
  }

  void addItem (String title) {
    _items.add(Item(title: title),);
    saveItemsToSharedPref(_items);
    notifyListeners();
  }

  void deleteItem (int index) {
    _items.removeAt(index);
    saveItemsToSharedPref(_items);
    notifyListeners();
  }

  List<String> _itemsAsString = [];
  UnmodifiableListView<Item> get items => UnmodifiableListView(_items);

  /// Shared Pref Metotları
  Future<void> createPrefObject() async {
    _sharedPref = await SharedPreferences.getInstance();
  }

  void saveItemsToSharedPref(List<Item> items) {
    //TODO:_items listesini List<String> ' çevir
    print('saveItemsToSharedPref çalıştı');
    _itemsAsString.clear();
    for (var item in items) {
      _itemsAsString.add(json.encode(item.toMap()));
    }

    //TODO: sharedprefe kaydet.
    _sharedPref!.setStringList('toDoData', _itemsAsString);
  }

  void loadItemsFromSharedPref() {
    List<String> tempList = _sharedPref!.getStringList('toDoData') ?? [];
    print('tempList:$tempList');
    _items.clear();
    for (var item in tempList) {
      _items.add(Item.fromMap(json.decode(item)));
    }
  }
}

