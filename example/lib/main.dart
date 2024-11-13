import 'package:carousel/constant.dart';
import 'package:carousel/transforom_card.dart';
import 'package:carousel_custom_slider/carousel_custom_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrangeAccent),
        useMaterial3: true,
      ),
      home: const Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              CarouselCustomSlider(
                doubleTapZoom: true,
                clipBehaviorZoom: true,
                autoPlay: false,
                height: 155,
                sliderList: sliderListImage,
              ),
              Container(
                height: 15,
                width: size.width,
                color: Theme.of(context).colorScheme.primaryContainer,
              ),
              CarouselCustomSlider(
                viewportFraction: 0.3,
                height: 150,
                sliderList: imageUrls,
                effect: JumpingDotEffect(
                  jumpScale: 2,
                  paintStyle: PaintingStyle.stroke,
                  dotHeight: 10,
                  dotWidth: 10,
                  dotColor: Theme.of(context).colorScheme.primaryContainer,
                  activeDotColor: Colors.deepOrangeAccent,
                ),
              ),
              Container(
                height: 15,
                width: size.width,
                color: Theme.of(context).colorScheme.primaryContainer,
              ),
              CarouselCustomSlider(
                fitPic: BoxFit.fitWidth,
                backgroundColor: Colors.pink,
                autoPlayCurve: Curves.bounceInOut,
                alignmentPositionIndicator: Alignment.topCenter,
                viewportFraction: 0.8,
                viewportFractionPaddingHorizontal: 15.0,
                height: 150,
                sliderList: imageUrls,
                effect: const WormEffect(
                  type: WormType.thinUnderground,
                  paintStyle: PaintingStyle.stroke,
                  dotHeight: 10,
                  dotWidth: 10,
                  dotColor: Colors.pink,
                  activeDotColor: Colors.purple,
                ),
              ),
              Container(
                height: 15,
                width: size.width,
                color: Theme.of(context).colorScheme.primaryContainer,
              ),
              CarouselCustomSlider(
                autoPlay: false,
                alignmentPositionIndicator: Alignment.bottomCenter,
                viewportFraction: 0.8,
                scrollDirection: Axis.vertical,
                viewportFractionPaddingVertical: 27.0,
                height: 270,
                sliderList: imageUrls,
                effect: const ExpandingDotsEffect(
                  paintStyle: PaintingStyle.fill,
                  dotHeight: 6,
                  dotWidth: 6,
                  dotColor: Colors.greenAccent,
                  activeDotColor: Colors.green,
                ),
              ),

              //paralax
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.skip_next_outlined),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Transformcard(),
            ),
          );
        },
      ),
    );
  }
}
