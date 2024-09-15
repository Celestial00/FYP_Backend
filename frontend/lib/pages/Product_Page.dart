import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_coffee/Models/Data.dart';
import 'package:my_coffee/pages/Favorite_Page.dart';

// ignore: must_be_immutable
class ProductPage extends StatefulWidget {
  String Name;
  String Price;
  String Desc;
  String Image_url;

  ProductPage({
    super.key,
    required this.Name,
    required this.Price,
    required this.Desc,
    required this.Image_url,
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
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: CachedNetworkImage(
                        imageUrl: widget.Image_url,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Center(
                          child: CircularProgressIndicator(),
                        ),
                        errorWidget: (context, url, error) => Center(
                          child: Icon(Icons.error, color: Colors.red),
                        ),
                      ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
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
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              widget.Desc,
              style: const TextStyle(fontSize: 13, color: Colors.white),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              "Size",
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: Row(
              children: [
                _buildSizeButton("L"),
                _buildSizeButton("M"),
                _buildSizeButton("S"),
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
                    const Text(
                      "Price",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      "\$ ${widget.Price}",
                      style: const TextStyle(fontSize: 20, color: Colors.orange),
                    )
                  ],
                ),
                Container(
                  width: 200,
                  height: 60,
                  decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(20)),
                  child: const Center(
                      child: Text(
                    "Buy Now",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  )),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSizeButton(String size) {
    return Container(
      margin: const EdgeInsets.only(right: 15),
      width: 100,
      height: 40,
      decoration: BoxDecoration(
        color: const Color(0xff262a32),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Text(
          size,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
