import 'package:flutter/material.dart';
import 'package:new_shopping_cart/widgets/custom_bottom_sheet.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton:
          FloatingActionButton(onPressed: () => customBottomSheet(context), child: const Icon(Icons.add)),
      appBar: AppBar(
        title: const Text('Shopping Cart'),
        centerTitle: true,
      ),
    );
  }

  void customBottomSheet(BuildContext context) async {
    await showModalBottomSheet(elevation: 5,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder( borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),),
      context: context,
      builder: (context) {
        return const CustomBottomSheet();
      },
    );
  }
}
