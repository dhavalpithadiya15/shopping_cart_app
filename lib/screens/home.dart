import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';

import 'package:new_shopping_cart/provider/shopping_cart_provider.dart';
import 'package:new_shopping_cart/screens/carts.dart';

import 'package:new_shopping_cart/widgets/custom_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/custom_list_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static SharedPreferences? preferences;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<ShoppingCartProvider>(context, listen: false).getAllProductData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => customBottomSheet(context),
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return CartsScreen();
              },));
            },
            icon: Icon(Icons.shopping_cart, size: 28),
          )
        ],
        title: const Text('Shopping Cart'),
        centerTitle: true,
      ),
      body: const CustomListTile(),
    );
  }

  void customBottomSheet(BuildContext context) async {
    await showModalBottomSheet(
      elevation: 5,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      context: context,
      builder: (context) {
        return const CustomBottomSheet();
      },
    );
  }
}
