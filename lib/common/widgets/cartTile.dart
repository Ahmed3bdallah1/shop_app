import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/provider/cart_provider/cartProvider.dart';
import '../../models/provider/cart_provider/cart_Item.dart';
import '../../screens/product_info.dart';


class CartTile extends StatefulWidget {
  const CartTile({super.key, required this.cartItem});

  final CartItem cartItem;

  @override
  State<CartTile> createState() => _CartTileState();
}

class _CartTileState extends State<CartTile> {
  int quantity = 0;
  late final CartProvider cart;
  late double totalPrice = widget.cartItem.product.price;

  @override
  void initState() {
    quantity = widget.cartItem.quantity;
    cart = context.read<CartProvider>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => ProductInfo(product: widget.cartItem.product)));
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white12,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(10)),
        height: 100,
        alignment: Alignment.topCenter,
        margin: const EdgeInsets.all(10),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(5),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(widget.cartItem.product.imageUrl)),
            ),
            const VerticalDivider(thickness: 1),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    widget.cartItem.product.title,
                    style: const TextStyle(
                        fontStyle: FontStyle.italic, fontSize: 13),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(widget.cartItem.product.price.toStringAsFixed(2),
                    style: const TextStyle(fontSize: 12)),
                const Spacer(flex: 1),
                Flexible(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: 'quantity: ',
                          style: const TextStyle(fontStyle: FontStyle.italic),
                          children: [
                            TextSpan(
                                text: quantity.toString(),
                                style: const TextStyle(
                                    fontStyle: FontStyle.italic,
                                    color: Colors.cyanAccent))
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(width: 10),
            Column(
              // crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.max,
              children: [
                Column(
                  children: [Text('Total price : $totalPrice le')],
                ),
                Row(children: [
                  ElevatedButton(
                      onPressed: () {
                        if (quantity == 1) {
                          cart.remove(widget.cartItem);
                        } else {
                          cart.items.removeWhere((element) =>
                              element.product.id == widget.cartItem.product.id);
                          setState(() {
                            quantity--;
                            totalPrice =
                                widget.cartItem.product.price * quantity;
                          });
                        }
                        print(cart.items);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red.shade900,
                          padding: const EdgeInsets.all(-5)),
                      child: const Icon(
                        Icons.remove_circle_outline,
                        size: 15,
                      )),
                  ElevatedButton(
                      onPressed: () {
                        cart.items.indexWhere((cartItem) =>
                            cartItem.product.id == widget.cartItem.product.id);

                        setState(() {
                          quantity++;
                          totalPrice = widget.cartItem.product.price * quantity;
                          widget.cartItem.product.totalProductPrice = totalPrice;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.cyan,
                          padding: const EdgeInsets.all(-5)),
                      child: const Icon(
                        Icons.add_circle_outline,
                        size: 15,
                      )),
                ]),
              ],
            )
          ],
        ),
      ),
    );
  }
}
