import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:x_store_new/screens/check_out.dart';
import 'package:x_store_new/screens/home_screen.dart';
import 'package:x_store_new/screens/cart_screen.dart';
import 'package:x_store_new/screens/favorite_screen.dart';
import 'package:x_store_new/screens/splash_screen.dart';

import 'models/provider/cart_provider/cartProvider.dart';
import 'models/provider/favorite_provider/favorite_Provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (BuildContext context) => CartProvider()),
        ChangeNotifierProvider(
            create: (BuildContext context) => FavoriteProvider()),
      ],
      child: MaterialApp(
        title: 'x store',
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
        routes: {
          HomeScreen.route: (BuildContext context) => const HomeScreen(),
          CartScreen.route: (BuildContext context) => const CartScreen(),
          FavoriteScreen.route: (BuildContext context) =>
          const FavoriteScreen(),
          CheckOut.route: (BuildContext context) => const CheckOut(),
          // LoginScreen.route: (BuildContext context) => LoginScreen(),
          // SignupScreen.route: (BuildContext context) => const SignupScreen(),
        },
      ),
    );
  }
}
