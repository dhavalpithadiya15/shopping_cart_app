import 'package:flutter/material.dart';
import 'package:new_shopping_cart/database/database_helper.dart';

import 'package:new_shopping_cart/provider/shopping_cart_provider.dart';
import 'package:new_shopping_cart/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';

class CustomBottomSheet extends StatelessWidget {
  const CustomBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController productNameController = TextEditingController();
    TextEditingController productPriceController = TextEditingController();

    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return StatefulBuilder(
      builder: (context, setState) {
        return Container(
          padding: EdgeInsets.only(
            left: 10,
            right: 10,
            top: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Text(
                  'Add Product',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.7),
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  label: 'Product Name',
                  controller: productNameController,
                  validator: (value) {
                    if (value != null) {
                      if (value.isEmpty) {
                        return 'Please fill the TextField';
                      }
                    } else {
                      print('NULL TEXT FIELD');
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  textInputType: TextInputType.number,
                  label: 'Product Price',
                  controller: productPriceController,
                  validator: (value) {
                    if (value != null) {
                      if (value.isEmpty) {
                        return 'Please fill the TextField';
                      } else if (value.contains('.') || value.contains(',')) {
                        return 'Please enter a valid number!!';
                      }
                    } else {
                      print('NULL TEXT FIELD');
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: double.maxFinite,
                  child: ElevatedButton(
                    onPressed: () {
                      checkValidation(context, formKey).then((value) {
                        if (value) {
                          int tempQuantity=1;
                          DataBaseHelper.insertProductData(productNameController.text, productPriceController.text,tempQuantity).then((value) {
                            print('DATA INSERTED SUCESS');
                            Provider.of<ShoppingCartProvider>(context, listen: false).getAllProductData();
                          });
                        }
                      });
                    },
                    child: const Text('Add Product'),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Future<bool> checkValidation(
      BuildContext context, GlobalKey<FormState> formKey) async {
    if (formKey.currentState!.validate()) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Product added Sucessfully'),
        ),
      );
      return true;
    } else {
      print('VALIDATION SECTION ERROR');
      return false;
    }
  }
}
