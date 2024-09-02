import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import 'package:my_coffee/Components/CustomIcon.dart';

import 'package:my_coffee/Components/custon_slider.dart';
import 'package:my_coffee/Components/product_card.dart';

import 'package:my_coffee/Components/Search_Bar.dart';
import 'package:my_coffee/pages/Search_Page.dart';
import 'package:permission_handler/permission_handler.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File? imageFile;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        //Sidebar
        resizeToAvoidBottomInset: false,

        //AppBar
        backgroundColor: const Color(0xff0c0f14),

        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //upper Text

              //Search bar
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  child: Row(
                    children: [
                      Expanded(child: CustomSearchBar()),
                      SizedBox(
                        width: 10,
                      ),
                      InkWell(
                          onTap: () async {
                            Map<Permission, PermissionStatus> status = await [
                              Permission.storage,
                              Permission.camera,
                            ].request();

                            if (status[Permission.camera]!.isGranted) {
                              print('sup');

                              showImagePicker(context);
                            } else {
                              print('nope');
                            }
                          },
                          child: Customicon()),
                    ],
                  )),

              const SizedBox(
                height: 5,
              ),

              // horizental option Menu

              Container(
                margin: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                child: const Text(
                  "trending",
                  style: TextStyle(fontFamily: "Bebas", fontSize: 25),
                ),
              ),

              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 500,
                child: CustomCarousel(
                  imageList: const [
                    "https://images.pexels.com/photos/5214139/pexels-photo-5214139.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
                    "https://images.pexels.com/photos/1335463/pexels-photo-1335463.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"
                  ],
                ),
              ),

              Container(
                margin: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                child: const Text(
                  "Products",
                  style: TextStyle(fontFamily: "Bebas", fontSize: 25),
                ),
              ),

              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 4,
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200.0,
                      childAspectRatio: 0.75, // Adjusted for taller content
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 20.0,
                    ),
                    itemBuilder: (context, index) {
                      return const ProductCard();
                    },
                  ),
                ),
              )
            ],
          ),
        ),

        //BottomNavBar
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
                          Icon(
                            Icons.image,
                            size: 60.0,
                          ),
                          SizedBox(height: 12.0),
                          Text(
                            "Gallery",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          )
                        ],
                      ),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.pop(context);
                      },
                    )),
                    Expanded(
                        child: InkWell(
                      child: SizedBox(
                        child: Column(
                          children: const [
                            Icon(
                              Icons.camera_alt,
                              size: 60.0,
                            ),
                            SizedBox(height: 12.0),
                            Text(
                              "Camera",
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(fontSize: 16, color: Colors.black),
                            )
                          ],
                        ),
                      ),
                      onTap: () {
                        _imgFromCamera();
                        Navigator.pop(context);
                      },
                    ))
                  ],
                )),
          );
        });
  }

  _imgFromGallery() async {
    await picker
        .pickImage(source: ImageSource.gallery, imageQuality: 50)
        .then((value) {
      if (value != null) {
        _cropImage(File(value.path));
      }
    });
  }

  _imgFromCamera() async {
    await picker
        .pickImage(source: ImageSource.camera, imageQuality: 50)
        .then((value) {
      if (value != null) {
        _cropImage(File(value.path));
      }
    });
  }

  _cropImage(File imgFile) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: imgFile.path,
      aspectRatio:
          CropAspectRatio(ratioX: 3.0, ratioY: 2.0), // Custom aspect ratio
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
      imageCache.clear();
      File imageFile = File(croppedFile?.path ?? '');

      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SearchPage(
                    imageFile: imageFile,
                )),
      );
    }
  }
}
