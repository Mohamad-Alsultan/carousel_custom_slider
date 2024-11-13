// ignore_for_file: library_private_types_in_public_api

import 'package:carousel_custom_slider/carousel_custom_slider.dart';
import 'package:flutter/material.dart';

/// A customizable carousel slider widget with various configurations and effects.
///
/// This widget displays a carousel slider with options for directionality, page control,
/// custom child widgets, and visual effects. It supports displaying images with optional
/// color filters and caching options.
///
/// Example usage:
/// ```dart
/// AdvancedCarouselSlider(
///   slides: [
///     'https://example.com/image1.jpg',
///     'https://example.com/image2.jpg',
///     // ...
///   ],
///   height: 90,
///   width: 300,
///   initialPage: 0,
///   viewportFraction: 0.9,
///   backgroundColor: Colors.white,
///   fit: BoxFit.cover,
///   effect: WormEffect(),
///   childrenStackBuilder: (index) {
///     return Text(
///       'Slide ${index + 1}',
///       style: TextStyle(color: Colors.white, fontSize: 24),
///     );
///   },
/// ),
/// ```

class AdvancedCarouselSlider extends StatefulWidget {
  /// [slides] is a list of images or other content that will be displayed in the carousel.
  final List<String> slides;

  /// [height] The height of the carousel. Defaults to 100. between 0.0 and 100.0 percent
  final double? height;

  /// [width] The width of the carousel. Defaults to 100. between 0.0 and 100.0 percent.
  final double? width;

  /// [viewportFraction] is the fraction of the viewport that each card occupies.
  final double viewportFraction;

  /// [directionality] is the text direction of the carousel.
  final TextDirection directionality;

  /// [initialPage] is the initial page to display. Defaults to 1.
  final int initialPage;

  /// [backgroundColor] is the background color of the carousel.
  final Color backgroundColor;

  /// [fit] is the fit of the carousel.
  final BoxFit fit;

  /// [colorFilter] is the color filter of the carousel. Defaults to=>
  /// ```dart
  /// ColorFilter.mode(
  ///    Colors.black
  ///   .withOpacity(isCurrentPage ? 0.3 : 0.9),
  ///  BlendMode.xor,
  /// ),
  /// ```
  final ColorFilter? colorFilter;

  /// The direction in which the carousel scrolls.
  final Axis scrollDirection;

  /// The alignment position of the indicator.
  final AlignmentGeometry alignmentPositionIndicator;

  /// Whether to display the indicator.
  final bool isDisplayIndicator;

  /// The effect to apply to the carousel items.
  ///
  /// You can use various effects like:
  /// ```dart
  /// effect : WormEffect(),
  /// effect : JumpingDotEffect(),
  /// effect : ScaleEffect(),
  /// effect : ScrollingDotsEffect(),
  /// effect : SlideEffect(),
  /// effect : ExpandingDotsEffect(),
  /// effect : SwapEffect(
  ///   dotHeight: 12.0,
  ///   dotWidth: 12.0,
  ///   paintStyle: PaintingStyle.fill,
  ///   type: SwapType.yRotation,
  ///   activeDotColor: Theme.of(context).primaryColor,
  ///   dotColor: Theme.of(context).colorScheme.inversePrimary,
  /// ),
  /// ```
  final IndicatorEffect effect;

  /// The axis direction of the indicator.
  final Axis axisDirectionIndicator;

  /// The text direction of the indicator.
  final TextDirection? textDirectionIndicator;

  /// Callback function called when a dot indicator is clicked.
  final void Function(int)? onDotClicked;

  /// The height of the cache image.
  final int? cacheHeigh;

  /// The width of the cache image.
  final int? cacheWidth;

  /// A builder function that returns a widget to display on top of each slide.
  ///
  /// The function receives the index of the current slide and returns a widget.
  final Widget? Function(int index) childrenStackBuilder;

  /// Creates an instance of [AdvancedCarouselSlider].
  ///
  /// All parameters except [slides] are optional. If not provided, default values will be used.

  const AdvancedCarouselSlider({
    super.key,
    required this.slides,
    this.height,
    this.width,
    this.viewportFraction = 0.8,
    this.directionality = TextDirection.ltr,
    this.initialPage = 1,
    this.backgroundColor = Colors.black,
    this.fit = BoxFit.cover,
    this.scrollDirection = Axis.horizontal,
    this.isDisplayIndicator = true,
    this.alignmentPositionIndicator = Alignment.bottomCenter,
    this.cacheHeigh = 300,
    this.cacheWidth = 300,
    this.colorFilter,
    this.axisDirectionIndicator = Axis.horizontal,
    this.textDirectionIndicator,
    this.onDotClicked,
    this.effect = const SlideEffect(
      dotHeight: 8,
      dotWidth: 8,
    ),
    this.childrenStackBuilder = defaultChildrenStackBuilder,
  });

  @override
  _AdvancedCarouselSliderState createState() => _AdvancedCarouselSliderState();
  static Widget? defaultChildrenStackBuilder(int index) => null;
}

class _AdvancedCarouselSliderState extends State<AdvancedCarouselSlider> {
  late PageController _controller;
  late int _currentPage;

  @override
  void initState() {
    _currentPage = widget.initialPage;
    _controller = PageController(
      viewportFraction: widget.viewportFraction,
      initialPage: _currentPage,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: widget.height ?? size.height * 0.9,
      width: widget.width ?? size.width,
      color: widget.backgroundColor,
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 9,
              child: SizedBox(
                child: PageView.builder(
                  controller: _controller,
                  scrollDirection: widget.scrollDirection,
                  physics: const BouncingScrollPhysics(),
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  itemCount: widget.slides.length,
                  itemBuilder: (context, index) {
                    bool isCurrentPage = index == _currentPage;
                    return Directionality(
                      textDirection: widget.directionality,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 800),
                        curve: Curves.ease,
                        margin: EdgeInsets.symmetric(
                            horizontal: 10, vertical: isCurrentPage ? 0 : 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            filterQuality: FilterQuality.high,
                            image: Image.network(
                              widget.slides[index],
                              height: double.infinity,
                              width: double.infinity,
                              cacheHeight: widget.cacheHeigh,
                              cacheWidth: widget.cacheWidth,
                            ).image,
                            fit: widget.fit,
                            colorFilter: widget.colorFilter ??
                                ColorFilter.mode(
                                  Colors.black
                                      .withOpacity(isCurrentPage ? 0.3 : 0.9),
                                  BlendMode.xor,
                                ),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: widget.childrenStackBuilder(index),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            if (widget.isDisplayIndicator)
              Expanded(
                flex: 1,
                child: SizedBox(
                  child: Align(
                    alignment: widget.alignmentPositionIndicator,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SmoothPageIndicator(
                        controller: _controller,
                        count: widget.slides.length,
                        effect: widget.effect,
                        axisDirection: widget.axisDirectionIndicator,
                        textDirection: widget.textDirectionIndicator,
                        onDotClicked: widget.onDotClicked,
                      ),
                    ),
                  ),
                ),
              )
            else
              const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
