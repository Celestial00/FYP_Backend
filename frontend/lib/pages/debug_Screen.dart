import 'package:flutter/material.dart';
import 'package:my_coffee/Components/product_card.dart';

class Debug_Screen extends StatelessWidget {
  const Debug_Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xff0c0f14),
      body: Center(
        child: ProductCard(),
      ),
    );
  }
}