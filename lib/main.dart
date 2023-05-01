import 'package:flutter/material.dart';
import 'package:new_shopping_cart/database/database_helper.dart';
import 'package:new_shopping_cart/screens/home.dart';

import 'package:provider/provider.dart';

import 'provider/shopping_cart_provider.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
 await DataBaseHelper.database;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ShoppingCartProvider>(create: (context) => ShoppingCartProvider(),child:  const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    ),);
  }
}
