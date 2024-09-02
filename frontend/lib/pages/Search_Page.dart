import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_coffee/Components/product_card.dart';

class SearchPage extends StatefulWidget {
  final File imageFile;
  SearchPage({super.key, required this.imageFile});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Color(0xff0c0f14),
      appBar: AppBar(
        title: Text(
          "Results ",
          style: TextStyle(fontFamily: 'Bebas'),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //search Image

              Text("Searched Image"),

              SizedBox(
                height: 10,
              ),

              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 4,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12), color: Colors.red),
                child: Image.file(
                  
                  widget.imageFile,
                  fit: BoxFit.cover,
                  
                ),
              ),

              //products
              SizedBox(
                height: 10,
              ),

              Text("Avliable Products"),

              SizedBox(
                height: 10,
              ),

              GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 4,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200.0,
                  childAspectRatio: 0.75, // Adjusted for taller content
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 20.0,
                ),
                itemBuilder: (context, index) {
                  return const ProductCard();
                },
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
