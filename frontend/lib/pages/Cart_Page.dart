import 'package:flutter/material.dart';
import 'package:my_coffee/Components/Order.dart';
import 'package:my_coffee/Models/Data.dart';

class CartPage extends StatefulWidget {
  CartPage({super.key});

  List list = Data().getCartData();

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  void onUpdate() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff0c0f14),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
        child: Column(
          children: [
            Text(
              "Cart",
              style: TextStyle(fontFamily: "Bebas", fontSize: 56),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: widget.list.length,
                  itemBuilder: ((contex, index) {
                    return OrderBox(
                      Name: widget.list[index],
                      onRemove: onUpdate,
                    );
                  })),
            ),
            Container(
              height: 70,
              width: 500,
              decoration: BoxDecoration(
                  color: const Color(0xff12161c),
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("total \$ 0.00"),
                    Container(
                      width: 60,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(child: Text("Buy")),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
    ;
  }
}


//   