import 'dart:ui';

import 'package:carousel_custom_slider/src/widget/custom_card_transform_widget.dart';
import 'package:carousel_custom_slider/transform_type.dart';
import 'package:flutter/material.dart';

///Example:
///
/// ```dart
/// TransformedCardSlider(
///   transformType: TransformType.skew1,
///   imageUrl: [
///     'image1.jpg',
///     'image2.jpg',
///     'image3.jpg',
///   ],
///   showBackgroundImage: false,
///   viewportFraction: 0.7,
///   borderRadius: BorderRadius.circular(16.0),
///   elevation: 10,
///   valueScalingFactor: 0.3,
///   customCurve: Curves.easeInOutBack,
///   shadowColor: Colors.pink,
///   dynamicHeight: 400,
///   horizontalTransform: 250,
///   children: const [
///   Positioned(
///   left: 25,
///   bottom: 25.0,
///   child: Text(
///   "transformType: TransformType.skew1",
///   style: TextStyle(color: Colors.white, fontSize: 30.0),
///   ),
///   )
///   ],
/// )
/// ```

class TransformedCardSlider extends StatefulWidget {
  /// The list of image URLs for the background image of each card.
  final List<String> imageUrl;

  /// The elevation of the card, which creates a shadow effect. Defaults to 0.0.
  final double elevation;

  /// The color of the shadow. Defaults to black.
  final Color? shadowColor;

  /// Determines whether to show the background image on the card. Defaults to true.
  final bool showBackgroundImage;

  /// The background color of the card. Defaults to white.
  final Color backgroundColor;

  /// The blur value for the background image. Defaults to 10.0.
  final double sigmaXBlurBackgroundImage;

  /// The initial page to be displayed in the card slider. Defaults to 1.
  final int initialPage;

  /// The fraction of the viewport occupied by each card in the slider. Defaults to 0.5.
  final double viewportFraction;

  /// Callback function when the card is tapped.
  final void Function()? onTap;

  /// Callback function when the card is double-tapped.
  final void Function()? onDoubleTap;

  /// Callback function when the card is long-pressed.
  final void Function()? onLongPress;

  /// The duration of the animation when transitioning between cards. Defaults to 700 microseconds.
  final Duration duration;

  /// The border radius of the card.
  final BorderRadiusGeometry? borderRadius;

  /// The border of the card.
  final BoxBorder? border;

  /// The background color of the card.
  final Color cardBackgroundColor;

  /// A builder function to customize the error widget.
  final Widget Function(BuildContext, Object, StackTrace?)? errorBuilder;

  /// A builder function to customize the frame of the card.
  final Widget Function(BuildContext, Widget, int?, bool)? frameBuilder;

  /// The height of the cached image.
  final int? cacheHeight;

  /// The width of the cached image.
  final int? cacheWidth;

  /// The scaling factor for the image value. Defaults to 0.5.
  final double valueScalingFactor;

  /// The dynamic height of the card. Defaults to 400.
  final int dynamicHeight;

  /// The horizontal transform of the card. Defaults to 250.
  final int horizontalTransform;

  /// The explicit height of the card.
  final double? height;

  /// The explicit width of the card.
  final double? width;

  /// The custom curve used for controlling the animation transition in the carousel.
  ///
  /// This curve defines the rate of change of an animation over time. The curve
  /// determines how the animation progresses from its initial state to its final
  /// state. By providing a custom curve, you can create unique animation effects
  /// with different rates of change.
  ///
  /// The [customCurve] can be any valid [Curve] instance from the Flutter framework,
  /// such as linear, easeIn, easeOut, cubic, etc.
  final Curve customCurve;

  /// The text direction of the displayed widget.
  final TextDirection directionality;

  /// The filter quality for widget images.
  final FilterQuality filterQuality;

  /// The fit property of the image widget.
  final BoxFit? fit;

  /// The transform type of the card. Defaults to [TransformType.skew].
  final TransformType transformType;

  /// A builder function that returns a widget to display on top of each slide.
  ///
  /// The function receives the index of the current slide and returns a widget.
  final List<Widget> Function(int index)? childrenStackBuilder;

  const TransformedCardSlider({
    super.key,
    required this.imageUrl,
    this.elevation = 0.0,
    this.shadowColor = Colors.black,
    this.showBackgroundImage = true,
    this.backgroundColor = Colors.white,
    this.sigmaXBlurBackgroundImage = 10.0,
    this.initialPage = 1,
    this.viewportFraction = 0.7,
    this.onTap,
    this.onDoubleTap,
    this.onLongPress,
    this.duration = const Duration(microseconds: 700),
    this.borderRadius = BorderRadius.zero,
    this.height,
    this.width,
    this.border,
    this.cardBackgroundColor = Colors.white70,
    this.errorBuilder,
    this.frameBuilder,
    this.cacheHeight = 1200,
    this.cacheWidth = 1200,
    this.valueScalingFactor = 0.5,
    this.dynamicHeight = 400,
    this.horizontalTransform = 250,
    this.customCurve = Curves.ease,
    this.directionality = TextDirection.ltr,
    this.filterQuality = FilterQuality.low,
    this.fit = BoxFit.fitHeight,
    this.transformType = TransformType.skew,
    this.childrenStackBuilder,
  });

  @override
  State<TransformedCardSlider> createState() => _TransformedCardSliderState();
}

class _TransformedCardSliderState extends State<TransformedCardSlider> {
  late final PageController _pageController;
  late int _currentPage;

  @override
  void initState() {
    super.initState();
    _currentPage = widget.initialPage;
    // Initial page
    _pageController = PageController(
      initialPage: _currentPage,
      viewportFraction: widget.viewportFraction,
      keepPage: true,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Directionality(
        textDirection: widget.directionality,
        child: GestureDetector(
          onTap: widget.onTap,
          onDoubleTap: widget.onDoubleTap,
          onLongPress: widget.onLongPress,
          child: Container(
            height: widget.height ?? size.height,
            width: widget.width ?? size.width,
            decoration: BoxDecoration(borderRadius: widget.borderRadius),
            child: Stack(
              children: [
                ImageFiltered(
                  imageFilter: ImageFilter.blur(
                    sigmaX: widget.showBackgroundImage
                        ? widget.sigmaXBlurBackgroundImage
                        : 0,
                    sigmaY: widget.showBackgroundImage
                        ? widget.sigmaXBlurBackgroundImage
                        : 0,
                  ),
                  child: Container(
                    width: size.width,
                    height: size.height,
                    decoration: widget.showBackgroundImage
                        ? BoxDecoration(
                            image: DecorationImage(
                              image: Image.network(
                                widget.imageUrl[_currentPage],
                                cacheHeight: widget.cacheHeight,
                                cacheWidth: widget.cacheWidth,
                                errorBuilder: widget.errorBuilder,
                              ).image,
                              fit: widget.fit,
                            ),
                          )
                        : BoxDecoration(
                            color: widget.backgroundColor,
                          ),
                  ),
                ),
                PageView.builder(
                  physics: const BouncingScrollPhysics(),
                  controller: _pageController,
                  itemCount: widget.imageUrl.length,
                  onPageChanged: (val) {
                    setState(() {
                      _currentPage = val;
                    });
                  },
                  itemBuilder: (context, index) {
                    final persent = (_currentPage - index);
                    final transValue = persent.clamp(0, 1.0);
                    return AnimatedSwitcher(
                      duration: widget.duration,
                      child: CustomCardTransformWidget(
                        widget: widget,
                        index: index,
                        pageController: _pageController,
                        imageOffset: transValue.toInt(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
