import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_coffee/Components/CustomIcon.dart';
import 'package:my_coffee/constants/Custom_colors.dart';
import 'package:my_coffee/pages/Product_Page.dart';

class ProductCard extends StatelessWidget {
  final String Name;
  final String Desc;
  final String Price;
  final String Image_Url;

  ProductCard({
    super.key,
    required this.Name,
    required this.Desc,
    required this.Price,
    required this.Image_Url,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double cardWidth = constraints.maxWidth * 0.4; // Responsive width
        double cardHeight = constraints.maxHeight * 0.4; // Responsive height

        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductPage(
                  Name: Name,
                  Price: Price,
                  Desc: Desc,
                  Image_url: Image_Url,
                ),
              ),
            );
          },
          child: Container(
            width: cardWidth,
            height: cardHeight,
            decoration: BoxDecoration(
              color: Color(0xff161b24),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                // Image section
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  child: AspectRatio(
                      aspectRatio: 1, // Adjust as needed to keep image ratio
                      child: CachedNetworkImage(
                        imageUrl: Image_Url,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Center(
                          child: CircularProgressIndicator(),
                        ),
                        errorWidget: (context, url, error) => Center(
                          child: Icon(Icons.error, color: Colors.red),
                        ),
                      )),
                ),

                // Product info
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "type",
                          style: TextStyle(
                            fontFamily: "Bebas",
                            color: Colors.grey[400],
                            fontSize: 11,
                          ),
                        ),
                        SizedBox(height: 3),
                        Text(
                          Desc,
                          style: TextStyle(
                            fontFamily: "metro",
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Price section
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SvgPicture.asset(
                        "Assets/icons/heart.svg",
                        width: 20,
                        height: 20,
                        color: Colors.orange,
                      ),
                      Text(
                        Price,
                        style: TextStyle(
                          fontFamily: "metro",
                          fontWeight: FontWeight.bold,
                          color: Colors.orange,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
