import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../common/widgets/custom_snak_bar.dart';
import '../models/product.dart';
import '../models/provider/favorite_provider/favorite_Provider.dart';
import '../models/provider/favorite_provider/favorite_item.dart';


class ProductInfo extends StatefulWidget {
  final Product product;

  const ProductInfo({super.key, required this.product});

  @override
  State<ProductInfo> createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo> {
  double opacity = 0;

  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) {
      setState(() {
        opacity = 1;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // late bool isFavorite;

    return Scaffold(
        // backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text(
            widget.product.title,
            style: const TextStyle(fontStyle: FontStyle.italic),
          ),
          shadowColor: Colors.grey,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                  aspectRatio: 10 / 8,
                  child: Stack(fit: StackFit.expand, children: [
                    Hero(
                      tag: widget.product,
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white12),
                        child: Image.network(widget.product.imageUrl),
                      ),
                    ),
                  ])),
              const Divider(
                color: Colors.white12,
              ),
              Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.product.title,
                        style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic),
                      ),
                      const Divider(
                        color: Colors.white38,
                        thickness: 1,
                      ),
                      AnimatedOpacity(
                          opacity: opacity,
                          curve: Curves.easeInOutSine,
                          duration: const Duration(seconds: 1),
                          child: Text(
                              'the price: ${widget.product.price.toStringAsFixed(2)}')),
                      const SizedBox(height: 2),
                      Text('units left: ${widget.product.stock}'),
                      const Divider(
                        color: Colors.white30,
                        thickness: 1,
                      ),
                      const Text('About this product:',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 5),
                      AnimatedOpacity(
                          opacity: opacity,
                          duration: const Duration(seconds: 2),
                          curve: Curves.easeInExpo,
                          child: Text(widget.product.description)),
                    ],
                  ))
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.red.shade900,
          foregroundColor: Colors.white,
          onPressed: () {
            if (context
                .read<FavoriteProvider>()
                .containsFavorite(widget.product)) {
              context
                  .read<FavoriteProvider>()
                  .remove(FavoriteItem(widget.product));
              showSnakBar(context,
                  "${widget.product.title} has removed from wish list");
            } else {
              context
                  .read<FavoriteProvider>()
                  .add(FavoriteItem(widget.product));
              showSnakBar(
                  context, "${widget.product.title} has added from wish list");
            }
          },
          child: Consumer<FavoriteProvider>(
            builder: (context, favorite, _) {
              return favorite.containsFavorite(widget.product)
                  ? const Icon(Icons.favorite)
                  : const Icon(Icons.favorite_border);
            },
          ),
          // child: (context
          //         .read<FavoriteProvider>()
          //         .containsFavorite(widget.product))
          //     ? const Icon(CupertinoIcons.check_mark)
          //     : const Icon(CupertinoIcons.heart),
        ));
  }
}
