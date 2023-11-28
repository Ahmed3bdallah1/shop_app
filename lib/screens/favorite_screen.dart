import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../common/widgets/favoriteTile.dart';
import '../models/provider/favorite_provider/favorite_Provider.dart';
import 'home_screen.dart';
import 'cart_screen.dart';


class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  static const route = 'favorite_Screen';

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    FavoriteProvider favoriteProvider = context.read<FavoriteProvider>();
    return Scaffold(
      // backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('favorites'),
            SizedBox(
              width: 5,
            ),
            Icon(CupertinoIcons.heart)
          ],
        ),
        shadowColor: Colors.grey,
      ),
      body: Consumer<FavoriteProvider>(builder: (context, favoriteProvider, _) {
        return favoriteProvider.favoriteitems.isEmpty
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
                itemBuilder: (_, index) => FavoriteTile(
                  favoriteItem: favoriteProvider.favoriteitems[index],
                  // product: dummyProducts.firstWhere((element) =>
                  //     element.id ==
                  //     favoriteProvider.favoriteitems[index].product.id),
                ),
                itemCount: favoriteProvider.favoriteitems.length,
              );
      }),
      bottomNavigationBar: favoriteProvider.favoriteitems.isEmpty
          ? ElevatedButton(
              onPressed: () =>
                  Navigator.pop(context),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [Icon(CupertinoIcons.back), Text('back')],
              ))
          : ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, CartScreen.route),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('go to your cart'),
                  SizedBox(
                    width: 5,
                  ),
                  Icon(CupertinoIcons.creditcard)
                ],
              )),
    );
  }
}
