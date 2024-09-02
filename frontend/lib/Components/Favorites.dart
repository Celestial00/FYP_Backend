import 'package:flutter/material.dart';
import 'package:my_coffee/Models/Data.dart';

class FavoriteBox extends StatefulWidget {
  final String Name;
  final Function() onRemove;

  const FavoriteBox({super.key, required this.Name, required this.onRemove});

  @override
  State<FavoriteBox> createState() => _FavoriteBoxState();
}

class _FavoriteBoxState extends State<FavoriteBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      margin: const EdgeInsets.symmetric(vertical: 5),
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
                Data().removeData(Name: widget.Name);
                widget.onRemove();
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
