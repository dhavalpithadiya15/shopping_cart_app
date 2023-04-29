import 'package:flutter/material.dart';
import 'package:new_shopping_cart/database/database_helper.dart';
import 'package:new_shopping_cart/modals/add_product_modal.dart';
import 'package:new_shopping_cart/widgets/custom_text_field.dart';

class CustomBottomSheet extends StatelessWidget {
  const CustomBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController productNameController = TextEditingController();
    TextEditingController productPriceController = TextEditingController();
    TextEditingController productQuantityController = TextEditingController();
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
                CustomTextField(
                  textInputType: TextInputType.number,
                  label: 'Product Quantity',
                  controller: productQuantityController,
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
                          DataBaseHelper.insertProductData(
                            ProductsModal(
                              name: productNameController.text,
                              price: productPriceController.text,
                              quantity: productQuantityController.text,
                            ),
                          ).then((value) {
                            print(value);
                          });
                        } else {}
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
