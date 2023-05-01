import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/shopping_cart_provider.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ShoppingCartProvider>(
      builder: (context, value, child) {
        if (value.isLoad == false) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (value.isProductDataListIsEmpty) {
          return const Center(
            child: Text('Tap on + Icon to add product!'),
          );
        } else {
          return ListView.builder(
            itemCount: value.allProductDataList.length,
            itemBuilder: (context, index) {
              return Card(
                elevation: 2,
                child: Container(
                  margin: const EdgeInsets.all(7),
                  height: MediaQuery.of(context).size.height * 0.12,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            '${index + 1}',
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          child: Column(
                            children: [
                              Expanded(
                                child: Container(
                                  alignment: Alignment.bottomLeft,
                                  child: Text(
                                    'Name : ${value.allProductDataList[index]['Name']}',
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Rs :${value.allProductDataList[index]['Price']}',
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.black.withOpacity(0.5),
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Column(
                          children: [
                            Expanded(
                                flex: 2,
                                child: Container(
                                  alignment: Alignment.bottomCenter,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      IconButton(
                                        onPressed: () =>
                                            value.increaseQuantity(index),
                                        icon: const Icon(
                                          Icons.add,
                                          size: 25,
                                          color: Colors.blue,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        '${value.allProductDataList[index]['Quantity']}',
                                        style: const TextStyle(
                                            fontSize: 16, color: Colors.grey,),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      IconButton(
                                        onPressed: () =>value.decreaseQuantity(index),
                                        icon: const Icon(
                                          Icons.remove,
                                          size: 25,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {

                                },
                                child: const Text('Add to Cart'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}
