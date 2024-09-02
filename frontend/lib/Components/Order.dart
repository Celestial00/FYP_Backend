import 'package:flutter/material.dart';
import 'package:my_coffee/Models/Data.dart';

class OrderBox extends StatefulWidget {
  String Name;
  final Function onRemove;
  OrderBox({super.key, required this.Name, required this.onRemove});

  @override
  State<OrderBox> createState() => _OrderBoxState();
}

class _OrderBoxState extends State<OrderBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      margin: const EdgeInsets.symmetric(vertical: 10),
      height: 70,
      width: 500,
      decoration: BoxDecoration(
          color: const Color(0xff12161c),
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.Name,
            style: const TextStyle(fontSize: 20),
          ),
          GestureDetector(
            onTap: () {
              print("sup");
            },
            child: GestureDetector(
              onTap: () {
                widget.onRemove();
                Data().removeCartData(Name: widget.Name);
              },
              child: Container(
                width: 30,
                height: 40,
                decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(10)),
                child: const Icon(
                  Icons.delete,
                  size: 20,
                ),
              ),
            ),
          )
        ],
      ),
    );
    ;
  }
}
