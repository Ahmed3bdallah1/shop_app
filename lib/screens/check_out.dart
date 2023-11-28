import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:x_store_new/models/auth/auth_model.dart';

import '../models/provider/cart_provider/cartProvider.dart';



class CheckOut extends StatefulWidget {
  const CheckOut({super.key});

  static const route = 'CheckOut';

  @override
  State<CheckOut> createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  late String name;
  late String email;
  late String number;
  late final addressController;
  late final secondNumberController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseAuthService auth=FirebaseAuthService();
    addressController=TextEditingController();
    secondNumberController=TextEditingController();
    name=auth.currentUser.displayName??'';
    email=auth.currentUser.email??"";
    number=auth.currentUser.phoneNumber??"";
  }

  @override
  Widget build(BuildContext context) {
    String generalAddress = "";
    CartProvider cart = context.watch<CartProvider>();


    return Scaffold(
      // backgroundColor: Colors.black,
      appBar: AppBar(
        shadowColor: Colors.white38,
        title: const Row(
          children: [
            Text('Checkout'),
            SizedBox(
              width: 5,
            ),
            Icon(CupertinoIcons.creditcard)
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(.2),
                borderRadius: BorderRadius.circular(10)),
            child: Form(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                child: Column(children: [
                  const Text('Order details', style: TextStyle(fontSize: 15)),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: addressController,
                    validator: (address) {
                      if (address != null) {
                        setState(() {
                          generalAddress = address;
                        });
                        return null;
                      } else {
                        return "please enter your address";
                      }
                    },
                    onFieldSubmitted: (address) {
                      setState(() {
                        generalAddress = address;
                      });
                    },
                    decoration: const InputDecoration(
                      labelText: 'Address',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: secondNumberController,
                    decoration: const InputDecoration(
                      labelText: 'second number (optional)',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const Divider(thickness: 2, color: Colors.white38),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Text('name : $name'),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Text('main number : $number'),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Text('email : $email'),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      addressController.text.isNotEmpty
                          ? Text('your address : $generalAddress}')
                          : const Text('u must enter an address'),
                    ],
                  ),
                  const SizedBox(height: 5),
                ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
