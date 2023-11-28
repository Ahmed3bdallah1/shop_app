import 'package:flutter/material.dart';
import 'package:x_store_new/models/product.dart';
import '../../screens/product_info.dart';
import 'addToCard.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard(this.product, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey.withOpacity(.3)),
      child: InkWell(
        onTap: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => ProductInfo(product: product))),
        child: Column(
          children: [
            Hero(
              tag: product,
              child: Image.network(
                product.imageUrl,
                height: 150,
                width: 120,
              ),
            ),
            const Divider(thickness: 1),
            Text(product.title),
            const Divider(
              thickness: 1,
            ),
            Text('${product.price} Le'),
            const SizedBox(height: 5),
            Column(children: [AddToCardButton(product)])
          ],
        ),
      ),
    );
  }
}
