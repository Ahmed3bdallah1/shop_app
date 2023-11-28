import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:x_store_new/models/product.dart';

import '../../models/provider/cart_provider/cartProvider.dart';
import '../../models/provider/cart_provider/cart_Item.dart';
import 'custom_snak_bar.dart';

class AddToCardButton extends StatefulWidget {
  const AddToCardButton(this.product, {super.key});

  final Product product;

  @override
  State<AddToCardButton> createState() => _AddToCardButtonState();
}

class _AddToCardButtonState extends State<AddToCardButton> {
  late final CartProvider provider;

  bool isInit = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (!isInit) {
      provider = context.watch<CartProvider>();
      isInit = true;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 5,
          disabledBackgroundColor: Colors.blue,
          disabledForegroundColor: Colors.white,
        ),
        onPressed: provider.containsCart(widget.product)
            ? () {
                provider.remove(CartItem(widget.product));
                showSnakBar(
                    context, "${widget.product.title} removed from cart");
              }
            : () {
                provider.add(CartItem(widget.product));
                print(context.read<CartProvider>().items);
                setState(() {
                  isInit = true;
                });
                showSnakBar(context, "${widget.product.title} added from cart");
              },
        child: provider.containsCart(widget.product)
            ? const Icon(Icons.check_circle_rounded)
            : const Icon(Icons.add_card));
  }
}
