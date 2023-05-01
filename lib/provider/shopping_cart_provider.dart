import 'package:flutter/widgets.dart';
import 'package:new_shopping_cart/database/database_helper.dart';


class ShoppingCartProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _allProductDataList = [];
  bool _isProductDataListIsEmpty = false;
  final List<int> _quantityValueStorage = [];
  bool _isLoad = false;

  List<Map<String, dynamic>> get allProductDataList => _allProductDataList;
  List<int> get quantityValueStorage => _quantityValueStorage;
  bool get isProductDataListIsEmpty => _isProductDataListIsEmpty;
  bool get isLoad => _isLoad;

  void getAllProductData() async {
    await DataBaseHelper.getProductData().then((value) {
      print(value);
      if (value.isNotEmpty) {
        _isProductDataListIsEmpty = false;
        _allProductDataList = value;
        _isLoad = true;

        notifyListeners();
      } else if (value.isEmpty) {
        _isLoad = true;
        _isProductDataListIsEmpty = true;
        notifyListeners();
        print('PRODUCT DATA LIST IS EMPTY');
      } else {
        _isLoad = false;
        notifyListeners();
      }
    });
    _quantityValueStorage.insert(_quantityValueStorage.length, 1);
  }

  void increaseQuantity(int index) {
    _quantityValueStorage[index]++;
    DataBaseHelper.updateQuantity(
        _quantityValueStorage[index], _allProductDataList[index]['id']);
    getAllProductData();
  }

  void decreaseQuantity(int index) {
    if (_quantityValueStorage[index] > 1) {
      _quantityValueStorage[index]--;
      DataBaseHelper.updateQuantity(
          _quantityValueStorage[index], _allProductDataList[index]['id']);
      getAllProductData();
    }
  }
}
