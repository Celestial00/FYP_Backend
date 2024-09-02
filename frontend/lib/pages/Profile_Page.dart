import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff0c0f14),
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back_ios_new)),
      ),
      backgroundColor: Color(0xff0c0f14),
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(top: 40),
          child: Column(
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Color(0xff12161c)),
                child: Icon(
                  Icons.person,
                  size: 40,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Demo Name",
                style: TextStyle(fontSize: 30, fontFamily: "Bebas"),
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                "Demo@gmail.com",
                style: TextStyle(fontSize: 13),
              ),
              SizedBox(
                height: 4,
              ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 80, vertical: 30),
                  child: Divider()),
            ],
          ),
        ),
      ),
    );
  }
}
