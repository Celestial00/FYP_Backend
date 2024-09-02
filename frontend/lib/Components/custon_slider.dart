import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CustomCarousel extends StatelessWidget {
  final List<String> imageList;
  final double height;
  final bool autoPlay;
  final bool enlargeCenterPage;
  final double aspectRatio;
  final double viewportFraction;

  CustomCarousel({
    required this.imageList,
    this.height = 500.0,
    this.autoPlay = true,
    this.enlargeCenterPage = true,
    this.aspectRatio = 16 / 9,
    this.viewportFraction = 0.9,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: CarouselSlider.builder(
        itemCount: imageList.length,
        itemBuilder: (context, index, realIndex) {
          final image = imageList[index];
          return Container(
            margin: EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              image: DecorationImage(
                image: NetworkImage(image),  // Use NetworkImage for remote URLs
                fit: BoxFit.cover,
              ),
            ),
          );
        },
        options: CarouselOptions(
          height: height,
          autoPlay: autoPlay,
          enlargeCenterPage: enlargeCenterPage,
          aspectRatio: aspectRatio,
          viewportFraction: viewportFraction,
          // Disable dots by not including the CarouselIndicator widget
        ),
      ),
    );
  }
}
