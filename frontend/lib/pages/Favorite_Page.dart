import 'package:flutter/material.dart';
import 'package:my_coffee/Components/Favorites.dart';
import 'package:my_coffee/Models/Data.dart';

class FavoritePage extends StatefulWidget {
  FavoritePage({super.key});

  List list = Data().getData();
  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
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
              "Favorite's",
              style: TextStyle(fontFamily: "Bebas", fontSize: 56),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: widget.list.length,
                  itemBuilder: ((contex, index) {
                    return FavoriteBox(
                      Name: widget.list[index],
                      onRemove: onUpdate,
                    );
                  })),
            )
          ],
        ),
      ),
    );
    ;
  }
}


//