import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_coffee/Components/CustomIcon.dart';
import 'package:my_coffee/constants/Custom_colors.dart';
import 'package:my_coffee/pages/Product_Page.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key});

  @override
  Widget build(BuildContext context) {


  double ScreenWidth = MediaQuery.of(context).size.width;
  double Screenheight = MediaQuery.of(context).size.height;


    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ProductPage(
                  Name: "sss",
                  Price: 222,
                  Desc: "222",
                  Image:
                      "https://images.unsplash.com/photo-1542291026-7eec264c27ff?q=80&w=2670&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D")),
        );
      },
      child: Container(
        width: ScreenWidth * 0.40,
        height: Screenheight * 0.40,
        decoration: BoxDecoration(
            color: Color(0xff161b24), borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            //image work

            const ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              child: Image(
                  image: NetworkImage(
                      "https://images.unsplash.com/photo-1542291026-7eec264c27ff?q=80&w=2670&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D")),
            ),

            // product info

            Container(
              margin: const EdgeInsets.only(left: 10, top: 10),
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
                  const SizedBox(
                    height: 3,
                  ),
                  const Text(
                    "hello there hw are youi good whatsup",
                    style: TextStyle(
                        fontFamily: "metro",
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),

            //price

            const SizedBox(
              height: 15,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Container(
                    width: 30,
                    height: 30,
                    child: SvgPicture.asset(
                      "Assets/icons/heart.svg",
                  
                      fit: BoxFit.scaleDown,
                      color: Colors.orange,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Text(
                    "333.30",
                    style: TextStyle(
                        fontFamily: "metro",
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                        fontSize: 15),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
