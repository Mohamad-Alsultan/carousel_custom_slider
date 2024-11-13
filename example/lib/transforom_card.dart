// ignore_for_file: implementation_imports

import 'package:carousel/constant.dart';
import 'package:carousel_custom_slider/carousel_custom_slider.dart';
import 'package:flutter/material.dart';

class Transformcard extends StatelessWidget {
  const Transformcard({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transformcard'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CarouselCustomSlider.transFormedCardSlider(
              height: 400,
              transformType: TransformType.skew,
              imageUrl: sliderListImage,
              valueScalingFactor: 0.4, //BorderSide.strokeAlignCenter
              viewportFraction: 0.7,
              customCurve: Curves.bounceInOut,
            ),
            const SizedBox(height: 15.0),
            CarouselCustomSlider.transFormedCardSlider(
              height: 400,
              transformType: TransformType.skew1,
              imageUrl: sliderListImage,
              valueScalingFactor: 0.3, //BorderSide.strokeAlignCenter
              viewportFraction: 0.7,
              customCurve: Curves.bounceInOut,
            ),
            const SizedBox(height: 15.0),
            CarouselCustomSlider.transFormedCardSlider(
              height: 400,
              transformType: TransformType.skew2,
              imageUrl: sliderListImage,
              valueScalingFactor: 0.3, //BorderSide.strokeAlignCenter
              viewportFraction: 0.7,
              customCurve: Curves.bounceInOut,
            ),
            const SizedBox(height: 15.0),
            CarouselCustomSlider.transFormedCardSlider(
              height: 400,
              transformType: TransformType.rotation,
              imageUrl: sliderListImage,
              valueScalingFactor: 0.3, //BorderSide.strokeAlignCenter
              viewportFraction: 0.7,
              customCurve: Curves.bounceInOut,
            ),
            const SizedBox(height: 15.0),
            CarouselCustomSlider.transFormedCardSlider(
              height: 400,
              transformType: TransformType.tryInvert,
              imageUrl: sliderListImage,
              valueScalingFactor: 0.3, //BorderSide.strokeAlignCenter
              viewportFraction: 0.7,
              customCurve: Curves.bounceInOut,
            ),
            const SizedBox(height: 15.0),
            CarouselCustomSlider.transFormedCardSlider(
              height: 400,
              transformType: TransformType.identity,
              imageUrl: sliderListImage,
              valueScalingFactor: 0.3, //BorderSide.strokeAlignCenter
              viewportFraction: 0.7,
              customCurve: Curves.bounceInOut,
            ),
          ],
        ),
      ),
    );
  }
}
