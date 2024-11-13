import 'package:carousel/constant.dart';
import 'package:carousel_custom_slider/carousel_custom_slider.dart';
import 'package:flutter/material.dart';

class Screen extends StatelessWidget {
  const Screen({super.key});
  @override
  Widget build(BuildContext context) {
    List<Widget> children = List.generate(
      listImage.length,
      (index) => Image.network(
        listImage[index],
        fit: BoxFit.cover,
        width: MediaQuery.of(context).size.width * 0.5,
        errorBuilder: (context, error, stackTrace) => const Placeholder(),
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Screen'),
      ),
      body: CarouselCustomSlider.autoScrollingWheel(
        autoPlay: false,
        height: 150,
        backgroundImageUrls: listImage,
        children: children,
      ),
    );
  }
}
