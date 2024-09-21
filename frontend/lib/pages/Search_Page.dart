import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert'; // For jsonEncode
import 'package:flutter/material.dart';
import 'package:my_coffee/Components/product_card.dart';
import 'package:my_coffee/constants/Server_Add.dart';

class SearchPage extends StatefulWidget {
  final File imageFile;
  SearchPage({super.key, required this.imageFile});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  var LocalAddress = ServerAdd.GetAdd();
  var localImageAdd = ServerAdd.getAddLocImage();
  List<dynamic> Products = [];

  Future<void> uploadImage(File imageFile) async {
    final url = Uri.parse(LocalAddress + '/upload'); // Replace with your URL

    final request = http.MultipartRequest('POST', url)
      ..fields['fieldName'] =
          'fieldValue' // Add any additional fields if needed
      ..files.add(await http.MultipartFile.fromPath('file', imageFile.path));

    final response = await request
        .send(); // Sends the request and returns a StreamedResponse

    // Get the response body as a string
    final responseBody = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      print("Upload successful");

      // Decode the response body as JSON
      final jsonData = jsonDecode(responseBody);

      Products = jsonData;

      setState(() {
        
      });

     
   
      // You can use the 'products' list to display data in your UI
    } else {
      print('Failed to upload image');
      print("Response: $responseBody");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => uploadImage(widget.imageFile),
        backgroundColor: Color(0xFF151515),
        child: Icon(Icons.search_outlined),
      ),
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
                itemCount: Products.length,
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200.0,
                  childAspectRatio: 0.75, // Adjusted for taller content
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 20.0,
                ),
                itemBuilder: (context, index) {

                         final product = Products[index];

                  return ProductCard(
                    Name: product['product_name'],
                    Desc: product['description'],
                    Price: product['price'],
                    Image_Url: localImageAdd + product['image_path'],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
