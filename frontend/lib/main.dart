import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_coffee/pages/Cart_Page.dart';
import 'package:my_coffee/pages/Favorite_Page.dart';
import 'package:my_coffee/pages/Home_Page.dart';
import 'package:flutter/services.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _index = 0;
     bool Debug_Mood = false;
  final List Pages = [const HomePage(), FavoritePage(), CartPage()];

  void ChangePage(int index) {
    setState(() {
      _index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "My Coffee",
      debugShowCheckedModeBanner: false,
      theme:
          ThemeData(brightness: Brightness.dark, primarySwatch: Colors.orange),
      home: Scaffold(
          //bottom navigation

          bottomNavigationBar: BottomNavigationBar(
              onTap: ChangePage,
              currentIndex: _index,
             
              backgroundColor: const Color(0xff0c0f14),
              elevation: 0,
              items:  [
                BottomNavigationBarItem(icon: SvgPicture.asset("Assets/icons/home.svg",  color: _index == 0 ? Colors.orange : Colors.grey[600], ), label: ''),
                BottomNavigationBarItem(icon: SvgPicture.asset("Assets/icons/heart.svg", color: _index == 1 ? Colors.orange : Colors.grey[600], ), label: ''),
                BottomNavigationBarItem(
                    icon: SvgPicture.asset("Assets/icons/cart.svg",  color: _index == 2 ? Colors.orange : Colors.grey[600],), label: '')
              ]),

          //body
          body: Pages[_index] ),
    );
  }
}

//Pages[_index]