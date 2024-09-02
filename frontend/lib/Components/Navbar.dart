import 'package:flutter/material.dart';

class Navbar extends StatelessWidget {
  const Navbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color(0xff0c0f14),
      child: ListView(
        children: const [
          UserAccountsDrawerHeader(
            accountName: Text("Demo"),
            accountEmail: Text("Demo@gmail.com"),
            currentAccountPicture: CircleAvatar(
              child: Icon(Icons.person),
            ),
            decoration: BoxDecoration(color: Color(0xff0c0f14)),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text("Home"),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text("Profile"),
          ),
          ListTile(
            leading: Icon(Icons.shopping_cart),
            title: Text("Cart"),
          ),
          ListTile(
            leading: Icon(Icons.shopping_bag_sharp),
            title: Text("Orders"),
          ),
          ListTile(
            leading: Icon(Icons.new_label),
            title: Text("New"),
          ),
        ],
      ),
    );
  }
}
