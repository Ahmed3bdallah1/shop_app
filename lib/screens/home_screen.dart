import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:x_store_new/models/auth/auth_model.dart';
import '../common/widgets/ProductCard.dart';
import '../models/product.dart';
import '../network/repos/products_dio_repo.dart';
import 'category_screen.dart';
import 'cart_screen.dart';
import 'favorite_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const route = 'Home_Screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.grey,
        centerTitle: true,
        title: Image.asset(
          'assets/images/x.png',
          alignment: Alignment.center,
          height: 50,
        ),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return CupertinoAlertDialog(
                      title: const Text('Logout'),
                      content: const Text('Are you sure you want to logout?'),
                      actions: [
                        CupertinoDialogAction(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Cancel')),
                        CupertinoDialogAction(
                            onPressed: () {
                              FirebaseAuthService().logout();
                              Navigator.of(context).pop();
                            },
                            child: const Text('Ok')),
                      ],
                    );
                  });
            },
            icon: const Icon(CupertinoIcons.person_crop_circle_badge_minus),
          ),
          PopupMenuButton(
              color: Colors.white,
              icon: const Icon(CupertinoIcons.settings),
              itemBuilder: (BuildContext context) => [
                    PopupMenuItem(
                      onTap: () {
                        Future.delayed(Duration.zero).then((value) =>
                            Navigator.pushNamed(context, CartScreen.route));
                      },
                      child: const Row(
                        children: [
                          Text(
                            '  Cart',
                            style: TextStyle(color: Colors.black),
                          ),
                          SizedBox(width: 5),
                          Icon(
                            CupertinoIcons.cart,
                            color: Colors.black,
                          )
                        ],
                      ),
                    ),
                    PopupMenuItem(
                        onTap: () {
                          // Navigator.of(context);
                          Future.delayed(Duration.zero).then((value) =>
                              Navigator.pushNamed(
                                  context, FavoriteScreen.route));
                        },
                        child: const Row(children: [
                          Text(
                            '  Favorites',
                            style: TextStyle(color: Colors.black),
                          ),
                          SizedBox(width: 5),
                          Icon(
                            CupertinoIcons.heart,
                            color: Colors.black,
                          )
                        ])),
                  ])
        ],
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              const SizedBox(height: 10),
              SizedBox(
                height: 80,
                child: ListView(scrollDirection: Axis.horizontal, children: [
                  Column(
                    children: [
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => const CategoryScreen()));
                            },
                            child: ClipOval(
                              child: Image.network(
                                'https://english.cdn.zeenews.com/sites/default/files/2022/02/20/1016233-iphone14.jpg',
                                width: 70,
                                height: 70,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          ClipOval(
                            child: Image.network(
                              'https://th.bing.com/th/id/R.d79e5ca7ac6e51ce0ac2e26365e87766?rik=mwLpSP%2fescGqMA&pid=ImgRaw&r=0',
                              width: 70,
                              height: 70,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          ClipOval(
                            child: Image.network(
                              'https://th.bing.com/th/id/R.a0bb639c702b8187846d5f8d4ef0c39a?rik=8hN6lRueL5xdqw&pid=ImgRaw&r=0',
                              width: 70,
                              height: 70,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          ClipOval(
                            child: Image.network(
                              'https://picsum.photos/200',
                              width: 70,
                              height: 70,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          ClipOval(
                            child: Image.network(
                              'https://picsum.photos/200',
                              width: 70,
                              height: 70,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          ClipOval(
                            child: Image.network(
                              'https://picsum.photos/200',
                              width: 70,
                              height: 70,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ]),
              ),
              const SizedBox(height: 10),
              const Divider(thickness: 3),
              Expanded(
                child: FutureBuilder<List<Product>?>(
                    future: DioNetwork().getProducts(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.data == null) {
                        return const Center(
                            child: Text('something went wrong !'));
                      }

                      if (snapshot.data!.isEmpty) {
                        return const Center(
                            child: Text('no products available right now'));
                      }

                      return GridView.builder(
                          itemCount: snapshot.data!.length,
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 300,
                                  mainAxisExtent: 300,
                                  crossAxisSpacing: 5),
                          itemBuilder: (_, index) {
                            return ProductCard(snapshot.data![index]);
                          });
                    }),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: SpeedDial(
        icon: Icons.card_travel_outlined,
        backgroundColor: Colors.white38,
        foregroundColor: Colors.white,
        children: [
          SpeedDialChild(
            child: const Icon(CupertinoIcons.cart),
            label: 'cart',
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            onTap: () {
              Navigator.pushNamed(context, CartScreen.route);
            },
          ),
          SpeedDialChild(
            child: const Icon(Icons.favorite),
            label: 'Favorites',
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            onTap: () {
              Navigator.pushNamed(context, FavoriteScreen.route);
            },
          ),
        ],
      ),
    );
  }
}
