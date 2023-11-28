import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../common/widgets/cartTile.dart';
import '../models/provider/cart_provider/cartProvider.dart';
import 'check_out.dart';
import 'home_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  static const route = 'Cart_Screen';

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    CartProvider cart = context.watch<CartProvider>();

    return Scaffold(
      // backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('cart'),
            SizedBox(
              width: 5,
            ),
            Icon(CupertinoIcons.cart)
          ],
        ),
        shadowColor: Colors.grey,
      ),
      body: Consumer<CartProvider>(builder: (context, cart, _) {
        return cart.items.isEmpty
            ? const Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: 100,
                    ),
                    Text('Nothing here!\n back to shop'),
                  ],
                ),
              )
            : ListView.builder(
                itemBuilder: (_, index) {
                  print(cart.items[index].product.totalProductPrice.toString());
                  return CartTile(
                    cartItem: cart.items[index]
                  );
                },
                itemCount: cart.items.length,
              );
      }),
      bottomNavigationBar: cart.items.isEmpty
          ? ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [Icon(CupertinoIcons.back), Text('back')],
              ))
          : ElevatedButton(
              onPressed: () {
                print(cart.items[0].product.totalProductPrice);
                // print(cart.items[1].product.totalProductPrice);
                Navigator.pushNamed(context, CheckOut.route);

              },
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Checkout'),
                  SizedBox(
                    width: 5,
                  ),
                  Icon(CupertinoIcons.creditcard)
                ],
              )),
    );
  }
}
