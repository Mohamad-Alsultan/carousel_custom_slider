import 'package:carousel/constant.dart';
import 'package:carousel_custom_slider/carousel_custom_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Homes extends StatelessWidget {
  const Homes({super.key});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Column(
          children: [
            CarouselCustomSlider(
              paddingVerticalPositionIndicator:
                  const EdgeInsets.symmetric(horizontal: 35.0),
              alignmentVerticalPositionIndicator: Alignment.centerRight,
              backgroundColor: Colors.greenAccent,
              width: size.width,
              viewportFraction: 0.8,
              scrollDirection: Axis.vertical,
              alignmentPositionIndicator: Alignment.bottomLeft,
              isVerticalIndicator: true,
              viewportFractionPaddingVertical: 20,
              viewportFractionPaddingHorizontal: 25,
              height: size.height * 0.5,
              sliderList: imageUrls,
              doubleTapZoom: true,
              clipBehaviorZoom: true,
              effect: const SwapEffect(
                  type: SwapType.yRotation, dotWidth: 8.0, dotHeight: 8.0),
            ),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
