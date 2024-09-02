import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomSearchBar extends StatefulWidget {
  const CustomSearchBar({super.key});

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        prefixIcon: SizedBox(
          width: 20, // Adjust as needed
          height: 20, // Adjust as needed
          child: SvgPicture.asset(
            "Assets/icons/search.svg",
                   height: 10, width: 10,
                     fit: BoxFit.scaleDown,
                     color: Colors.orange,
        
          ),
        ),
        hintText: "Search",
        hintStyle: TextStyle(fontFamily: "Bebas"),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.orange),
          borderRadius: BorderRadius.circular(12),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(12),
        ),
        fillColor: Color(0xff141921),
        filled: true,
      ),
    );
  }
}
