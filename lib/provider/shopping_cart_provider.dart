import 'package:flutter/widgets.dart';
import 'package:new_shopping_cart/database/database_helper.dart';
import 'package:new_shopping_cart/screens/home.dart';

class ShoppingCartProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _allProductDataList = [];
  bool _isProductDataListIsEmpty = false;
  final List<int> _quantityValueStorage = List.filled(1000, 1);
  bool _isLoad = false;
  final num _individualTotalPriceOfItem = 0.0;

  num get individualTotalPriceOfItem => _individualTotalPriceOfItem;

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
  }

  void increaseQuantity(int index) {
    _quantityValueStorage[index]++;
    notifyListeners();
  }

  void decreaseQuantity(int index) {
    if (_quantityValueStorage[index] > 1) {
      _quantityValueStorage[index]--;
      notifyListeners();
    }
  }
}

class CartProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _allCartItemList = [];

  List<Map<String, dynamic>> get allCartItemList => _allCartItemList;

  bool get isLoad => _isLoad;
int finalTotal= 0;


  bool _emptyCart = true;

  bool get emptyCart => _emptyCart;
  bool _isLoad = true;

  Future<void> getAllCartData() async {
    await DataBaseHelper.getProductDataFromCart().then((value) {
      if (value.isEmpty) {
        _isLoad = false;
        _emptyCart = true;
          finalTotal=0;
        notifyListeners();
      } else if (value.isNotEmpty) {
        _isLoad = false;
        _emptyCart = false;
        _allCartItemList = value;
        List list=[];
        for (var element in _allCartItemList) {
          {
            list.add(int.parse(element['ProductPrice'])*(element['Quantity']));
          }
        }
       finalTotal= list.reduce((value, element) => value+element);
        getAllCartData();
        notifyListeners();
      } else {
        _isLoad = true;
        notifyListeners();
      }
    });
  }

}
