import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/provider/favorite_provider/favorite_Provider.dart';
import '../../models/provider/favorite_provider/favorite_item.dart';
import '../../screens/product_info.dart';


class FavoriteTile extends StatefulWidget {
  const FavoriteTile({super.key, required this.favoriteItem});

  final FavoriteItem favoriteItem;

  @override
  State<FavoriteTile> createState() => _FavoriteTileState();
}

class _FavoriteTileState extends State<FavoriteTile> {
  @override
  Widget build(BuildContext context) {
    print(FavoriteTile);
    return InkWell(
      onTap: (){
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => ProductInfo(product: widget.favoriteItem.product)));
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey.withOpacity(.3),
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(10)),
        height: 100,
        margin: const EdgeInsets.all(10),
        child: Padding(
          padding: const EdgeInsets.only(right: 20),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsets.all(5),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(widget.favoriteItem.product.imageUrl)),
              ),
              const VerticalDivider(thickness: 1),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    widget.favoriteItem.product.title,
                    style:
                        const TextStyle(fontStyle: FontStyle.italic, fontSize: 16),
                  ),
                  // const SizedBox(
                  //   height: 5,
                  // ),
                  Text(widget.favoriteItem.product.price.toStringAsFixed(2),
                      style: const TextStyle(fontSize: 14)),
                ],
              ),
              const Spacer(),
              ElevatedButton(
                  onPressed: () {
                    context
                        .read<FavoriteProvider>()
                        .remove(FavoriteItem(widget.favoriteItem.product));
                  },
                  child: const Icon(CupertinoIcons.trash_circle))

              // Column(
              //   // crossAxisAlignment: CrossAxisAlignment.end,
              //   mainAxisAlignment: MainAxisAlignment.end,
              //   mainAxisSize: MainAxisSize.max,
              //   children: [
              //     Row(children: [
              //       ElevatedButton(
              //           onPressed: () {
              //             if (quantity == 1) {
              //               cart.removeWhere(
              //                       (element) => element.key == widget.product.id);
              //             } else if(quantity!=1){
              //               int index = cart.indexWhere(
              //                       (element) => element.key == widget.product.id);
              //
              //               cart[index] =
              //                   MapEntry(cart[index].key, (cart[index].value-1));
              //               setState(() {
              //                 quantity--;
              //               });
              //             }
              //             print(quantity);
              //           },
              //           style: ElevatedButton.styleFrom(
              //               backgroundColor: Colors.red.shade900,
              //               padding: const EdgeInsets.all(-5)),
              //           child: const Icon(
              //             Icons.remove_circle_outline,
              //             size: 15,
              //           )),
              //       ElevatedButton(
              //           onPressed: () {
              //             final index = cart.indexWhere(
              //                     (element) => element.key == widget.product.id);
              //
              //             cart[index] =
              //                 MapEntry(cart[index].key, cart[index].value);
              //             setState(() {
              //               quantity++;
              //             });
              //           },
              //           style: ElevatedButton.styleFrom(
              //               backgroundColor: Colors.cyan,
              //               padding: const EdgeInsets.all(-5)),
              //           child: const Icon(
              //             Icons.add_circle_outline,
              //             size: 15,
              //           )),
              //     ]),
              //   ],
              // )
            ],
          ),
        ),
      ),
    );
  }
}
