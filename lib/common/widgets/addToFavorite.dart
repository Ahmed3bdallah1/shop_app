import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:x_store_new/models/product.dart';

import '../../models/provider/favorite_provider/favorite_Provider.dart';
import '../../models/provider/favorite_provider/favorite_item.dart';


class AddToFavoriteButton extends StatefulWidget {
  const AddToFavoriteButton({super.key, required this.product});

  final Product product;

  @override
  State<AddToFavoriteButton> createState() => _AddToFavoriteButtonState();
}

class _AddToFavoriteButtonState extends State<AddToFavoriteButton> {
  late final FavoriteProvider provider;

  bool isInit = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (!isInit) {
      provider = context.watch<FavoriteProvider>();
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
      onPressed: provider.containsFavorite(widget.product)
          ? null
          : () {
              provider.add(FavoriteItem(widget.product));
              print(context.read<FavoriteProvider>().favoriteitems);
              setState(() {
                isInit = true;
              });
            },
      child: provider.containsFavorite(widget.product)
          ? const Icon(Icons.check_circle_rounded)
          : const Icon(Icons.add_card),
    );
  }
}
