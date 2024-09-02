import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_coffee/constants/Custom_colors.dart';
import 'package:permission_handler/permission_handler.dart';

class Customicon extends StatefulWidget {
  const Customicon({super.key});

  @override
  State<Customicon> createState() => _CustomiconState();
}

class _CustomiconState extends State<Customicon> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: CustomeColor.priColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: SvgPicture.asset("Assets/icons/camera.svg",      height: 5, width: 5,
      fit: BoxFit.scaleDown, color: Colors.orange, )
    );
  }
}
