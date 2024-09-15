import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';

import 'package:my_coffee/Components/CustomIcon.dart';
import 'package:my_coffee/Components/custon_slider.dart';
import 'package:my_coffee/Components/product_card.dart';
import 'package:my_coffee/Components/Search_Bar.dart';
import 'package:my_coffee/pages/Search_Page.dart';

class Product {
  final String id;
  final String name;
  final String description;
  final String price;
  final String imageUrl;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? 'Unknown ID', // Handle null values with defaults
      name: json['product_name'] ?? 'No Name',
      description: json['description'] ?? 'No Description',
      price: json['price'] != null ? json['price'].toString() : '0', // Convert price to String
      imageUrl: json['image_path'] ?? 'https://example.com/default-image.jpg', // Handle null image paths
    );
  }
}
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File? imageFile;
  List<Product> products = [];
  var localImageAdd = "http://192.168.10.5:5000/";

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    final response = await http.get(
      Uri.parse('http://192.168.10.5:5000/getProducts'),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = jsonDecode(response.body);
      setState(() {
        products = jsonResponse
            .map((data) => Product.fromJson(data))
            .toList();
      });
    } else {
      throw Exception('Failed to load products');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xff0c0f14),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                child: Row(
                  children: [
                    const Expanded(child: CustomSearchBar()),
                    const SizedBox(width: 10),
                    InkWell(
                      onTap: () async {
                        Map<Permission, PermissionStatus> status = await [
                          Permission.storage,
                          Permission.camera,
                        ].request();

                        if (status[Permission.camera]!.isGranted) {
                          showImagePicker(context);
                        } else {
                          print('nope');
                        }
                      },
                      child: const Customicon(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 5),
              
              // Trending Carousel
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                child: const Text(
                  "Trending",
                  style: TextStyle(fontFamily: "Bebas", fontSize: 25),
                ),
              ),

              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 500,
                child: CustomCarousel(
                  imageList: const [
                    "https://images.pexels.com/photos/5214139/pexels-photo-5214139.jpeg",
                    "https://images.pexels.com/photos/1335463/pexels-photo-1335463.jpeg",
                  ],
                ),
              ),

              // Product Grid
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                child: const Text(
                  "Products",
                  style: TextStyle(fontFamily: "Bebas", fontSize: 25),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: products.length,
                    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200.0,
                      childAspectRatio: 0.75,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 20.0,
                    ),
                    itemBuilder: (context, index) {
                      final product = products[index];

              

                      return ProductCard(
                        Name: product.name,
                        Desc: product.description,
                        Price: product.price,
                        Image_Url: localImageAdd + product.imageUrl,
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  final picker = ImagePicker();

  void showImagePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (builder) {
        return Card(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 5.2,
            margin: const EdgeInsets.only(top: 8.0),
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: InkWell(
                    child: Column(
                      children: const [
                        Icon(Icons.image, size: 60.0),
                        SizedBox(height: 12.0),
                        Text(
                          "Gallery",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      ],
                    ),
                    onTap: () {
                      _imgFromGallery();
                      Navigator.pop(context);
                    },
                  ),
                ),
                Expanded(
                  child: InkWell(
                    child: SizedBox(
                      child: Column(
                        children: const [
                          Icon(Icons.camera_alt, size: 60.0),
                          SizedBox(height: 12.0),
                          Text(
                            "Camera",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  _imgFromGallery() async {
    await picker.pickImage(source: ImageSource.gallery, imageQuality: 50).then((value) {
      if (value != null) {
        _cropImage(File(value.path));
      }
    });
  }

  _imgFromCamera() async {
    await picker.pickImage(source: ImageSource.camera, imageQuality: 50).then((value) {
      if (value != null) {
        _cropImage(File(value.path));
      }
    });
  }

  _cropImage(File imgFile) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: imgFile.path,
      aspectRatio: const CropAspectRatio(ratioX: 3.0, ratioY: 2.0),
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: "Image Cropper",
          toolbarColor: Colors.deepOrange,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
        ),
        IOSUiSettings(
          title: "Image Cropper",
        ),
      ],
    );

    if (croppedFile != null) {
      File imageFile = File(croppedFile.path);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SearchPage(imageFile: imageFile),
        ),
      );
    }
  }
}
