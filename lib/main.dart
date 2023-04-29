import 'package:flutter/material.dart';
import 'package:new_shopping_cart/database/database_helper.dart';
import 'package:new_shopping_cart/screens/home.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
 await DataBaseHelper.database;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
