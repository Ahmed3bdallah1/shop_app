import 'package:flutter/material.dart';
import '../../product.dart';
import 'favorite_item.dart';

class FavoriteProvider extends ChangeNotifier{

  final List<FavoriteItem> _favoriteItems=[];
  List<FavoriteItem> get favoriteitems=>_favoriteItems;

  void add(FavoriteItem item){
    _favoriteItems.add(item);
    notifyListeners();
  }

  void remove(FavoriteItem item){
    _favoriteItems.removeWhere((FavoriteItem) => FavoriteItem.product.id==item.product.id);
    notifyListeners();
  }

  bool containsFavorite(Product item){
    _favoriteItems.contains(item);
    final index= _favoriteItems.indexWhere((element) => element.product.id==item.id);
    return index>=0;
  }


  bool get isEmpty=>_favoriteItems.isEmpty;
}