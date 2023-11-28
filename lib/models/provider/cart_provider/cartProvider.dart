import 'package:flutter/cupertino.dart';

import '../../product.dart';
import 'cart_Item.dart';


class CartProvider extends ChangeNotifier{

  final List<CartItem> _items=[];
  List<CartItem> get items=>_items;

  void add(CartItem item){
    _items.add(item);
    notifyListeners();
  }

  void remove(CartItem item){
    _items.removeWhere((CartItem) => CartItem.product.id==item.product.id);
    notifyListeners();
  }

  bool containsCart(Product item){
    _items.contains(item);
    final index= _items.indexWhere((element) => element.product.id==item.id);

    return index>=0;
  }


  bool get isEmpty=>_items.isEmpty;
}