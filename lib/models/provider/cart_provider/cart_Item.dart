
import '../../product.dart';

class CartItem{
  final Product product;
  int quantity;

  CartItem(this.product,[this.quantity=1]);
}