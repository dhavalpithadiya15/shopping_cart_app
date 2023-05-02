import 'package:flutter/material.dart';
import 'package:new_shopping_cart/database/database_helper.dart';
import 'package:new_shopping_cart/provider/shopping_cart_provider.dart';
import 'package:provider/provider.dart';

class CartsScreen extends StatefulWidget {
  const CartsScreen({Key? key}) : super(key: key);

  @override
  State<CartsScreen> createState() => _CartsScreenState();
}

class _CartsScreenState extends State<CartsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<CartProvider>(context, listen: false).getAllCartData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: PhysicalModel(
        color: Colors.white,
        elevation: 5,
        child: Container(
          padding: const EdgeInsets.all(10),
          height: kToolbarHeight,
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                    alignment: Alignment.center,
                    child: Consumer<CartProvider>(
                      builder: (context, value, child) {
                        return Text(
                          'Total: ${value.finalTotal}',
                          style: const TextStyle(fontSize: 20),
                        );
                      },
                    )),
              ),
              Expanded(
                child: Container(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text('CheckOut'),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      appBar: AppBar(
        title: const Text('Cart'),
        centerTitle: true,
      ),
      body: Consumer<CartProvider>(
        builder: (context, value, child) {
          if (value.isLoad) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (value.emptyCart) {
            return const Center(
              child: Text(
                'Cart is Empty',
                style: TextStyle(fontSize: 18),
              ),
            );
          } else {
            return ListView.builder(
              itemCount: value.allCartItemList.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    leading: Container(
                      child: Text('${index + 1}'),
                    ),
                    title: Text(value.allCartItemList[index]['ProductName']),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          child: Text(
                              "${value.allCartItemList[index]['ProductPrice']} * ${value.allCartItemList[index]['Quantity']}"),
                        ),
                        IconButton(
                          onPressed: () async {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  alignment: Alignment.center,
                                  title: const Text('Are you sure want to delete ?'),
                                  elevation: 4,
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text(
                                        'No',
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        Navigator.pop(context);
                                        await DataBaseHelper.deleteItemFromCart(
                                            value.allCartItemList[index]['id']).then((_) {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(
                                              content: Text('Deleted Successfully'),
                                            ),
                                          );
                                        });
                                      },
                                      child: const Text(
                                        'Yes',
                                        style: TextStyle(color: Colors.green),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );


                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
