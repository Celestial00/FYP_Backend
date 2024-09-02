import 'package:flutter/material.dart';
import 'package:my_coffee/Models/Data.dart';
import 'package:my_coffee/pages/Favorite_Page.dart';

// ignore: must_be_immutable
class ProductPage extends StatefulWidget {
  String Name;
  double Price;
  String Desc;
  String Image;

  ProductPage({
    super.key,
    required this.Name,
    required this.Price,
    required this.Desc,
    required this.Image,
  });

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {

  @override
  Widget build(BuildContext context) {

  double ScreenWidth = MediaQuery.of(context).size.width;
  double Screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xff0c0f14),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: <Widget>[
              Container(
                width: ScreenWidth,
                height: Screenheight * 0.40,
                decoration:  BoxDecoration( borderRadius: BorderRadius.circular(12)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image(
                      image: NetworkImage(
                        widget.Image,
                      ),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.orange,
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          Data().setData(Name: widget.Name);
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (_) {
                            return FavoritePage();
                          }));
                        },
                        icon: Icon(
                          Icons.favorite,
                          color: Colors.orange,
                        ))
                  ],
                ),
              )
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(top: 20, left: 20),
            child: Text(
              "Description",
              style: TextStyle(fontSize: 18),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              widget.Desc,
              style: const TextStyle(fontSize: 13),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text("Size"),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 15),
                  width: 100,
                  height: 40,
                  decoration: BoxDecoration(
                      color: const Color(0xff262a32),
                      borderRadius: BorderRadius.circular(20)),
                  child: const Center(child: Text("L")),
                ),
                Container(
                  margin: const EdgeInsets.only(right: 15),
                  width: 100,
                  height: 40,
                  decoration: BoxDecoration(
                      color: const Color(0xff262a32),
                      borderRadius: BorderRadius.circular(20)),
                  child: const Center(child: Text("M")),
                ),
                Container(
                  margin: const EdgeInsets.only(right: 15),
                  width: 100,
                  height: 40,
                  decoration: BoxDecoration(
                      color: const Color(0xff262a32),
                      borderRadius: BorderRadius.circular(20)),
                  child: const Center(child: Text("S")),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 40, left: 40, right: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    const Text("price"),
                    const SizedBox(
                      height: 3,
                    ),
                    Text(
                      "\$ ${widget.Price}",
                      style: const TextStyle(fontSize: 20),
                    )
                  ],
                ),
                Container(
                  width: 200,
                  height: 60,
                  decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(20)),
                  child: const Center(child: Text("Buy Now")),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
