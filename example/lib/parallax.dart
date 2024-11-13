import 'package:carousel/constant.dart';
import 'package:carousel_custom_slider/carousel_custom_slider.dart';
import 'package:flutter/material.dart';

class Parallax extends StatelessWidget {
  const Parallax({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Parallax'),
      ),
      body: Center(
        child: CarouselCustomSlider.parallax(
          imageUrl: sliderListImage,
          // height: 400,
          showBackgroundImage: true,
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(color: Colors.white, width: 5.0),
          customCurve: Curves.easeInOutBack,
          shadowColor: Colors.pink,
          horizontalTransform: 250,

          ///You may sometimes get container box error, you need to change [viewportFraction] , [valueScalingFactor] , [horizontalTransform] , [dynamicHeight] value to match with one another,
          /// most of the time the problem is solved by changing these two [viewportFraction] , [valueScalingFactor] .
          valueScalingFactor: 0.4,
          viewportFraction: 0.8,
          dynamicHeight: 600,
          children: [
            const Positioned(
              left: 25,
              bottom: 25.0,
              child: Text(
                'Parallax',
                style: TextStyle(color: Colors.white, fontSize: 30.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
