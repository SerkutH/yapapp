import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yapapp/models/item.dart';
import 'package:yapapp/models/items_data.dart';
import 'package:yapapp/screens/home_page.dart';
import './models/color_theme_data.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ColorThemeData().createPrefObject();
  await ItemData().createPrefObject();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<ItemData>(
      create: (BuildContext context) => ItemData(),
    ),
    ChangeNotifierProvider<ColorThemeData>(
        create: (BuildContext context) => ColorThemeData()),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Provider.of<ColorThemeData>(context).loadThemeFromSharedPreferences();
    Provider.of<ItemData>(context).loadItemsFromSharedPref();
    return MaterialApp(
      theme: Provider.of<ColorThemeData>(context).selectedThemeData,
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

