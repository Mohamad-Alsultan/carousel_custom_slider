import 'dart:async';

import 'package:carousel_custom_slider/src/widget/reflection_widget.dart';
import 'package:flutter/material.dart';

///Example:
///
/// ```dart
/// CarouselCustomSlider.Reflection(
///   sliderList: [
///     'image1.jpg',
///     'image2.jpg',
///     'image3.jpg',
///   ],
///   showReflection: true,
///   height: 200,
///   fit: BoxFit.fill,
///   children : [],
/// ```

class Reflection extends StatefulWidget {
  /// [sliderList]: The list of images to display.
  final List sliderList;

  /// [width]: The width of the image.
  final double width;

  /// [height]: The height of the image.
  final double height;

  /// [autoPlay]: Whether to automatically play the carousel.
  final bool autoPlay;

  /// [autoPlayInterval]: The interval between auto play animations.
  final Duration autoPlayInterval;

  /// [autoPlayAnimationDuration]: The duration of auto play animations.
  final Duration autoPlayAnimationDuration;

  /// [autoPlayCurve]: The curve of auto play animations.
  final Curve autoPlayCurve;

  /// [shadowColorStart]: The color of the shadow.
  final Color shadowColorStart;

  /// [shadowColorEnd]: The color of the shadow.
  final Color shadowColorEnd;

  /// [reflectionOpacity]: The opacity of the reflection. Defaults to 0.4. between 0.0 and 1.0
  final double reflectionOpacity;

  /// [reflectionBlendMode]: The blend mode of the reflection . Defaults BlendMode.xor.
  final BlendMode reflectionBlendMode;

  /// [cacheHeight]: The height of the cache.
  final int cacheHeight;

  /// [cacheWidth]: The width of the cache.
  final int cacheWidth;

  /// [fit]: The fit of the image.
  final BoxFit? fit;

  /// [onTap]: The callback when the image is tapped.
  final void Function()? onTap;

  /// [errorBuilder]: The error builde ImageBuilder.
  final Widget Function(BuildContext, Object, StackTrace?)? errorBuilder;

  /// [borderColor]: The color of the border.
  final Color? borderColor;

  /// [showReflection]: Whether to show the reflection.
  final bool showReflection;

  /// A builder function that returns a widget to display on top of each slide.
  ///
  /// The function receives the index of the current slide and returns a widget.
  final Widget? Function(int index)? childrenStackBuilder;
  const Reflection({
    super.key,
    required this.sliderList,
    required this.width,
    required this.height,
    this.autoPlay = true,
    this.autoPlayInterval = const Duration(seconds: 5),
    this.autoPlayAnimationDuration = const Duration(seconds: 2),
    this.autoPlayCurve = Curves.ease,
    this.shadowColorStart = const Color.fromRGBO(0, 0, 0, 0.4),
    this.shadowColorEnd = const Color.fromRGBO(0, 0, 0, 0.9),
    this.reflectionOpacity = 0.4,
    this.reflectionBlendMode = BlendMode.dst,
    this.cacheHeight = 200,
    this.cacheWidth = 200,
    this.fit = BoxFit.fill,
    this.errorBuilder,
    this.onTap,
    this.borderColor,
    this.showReflection = true,
    this.childrenStackBuilder,
  });

  @override
  State<Reflection> createState() => _ReflectionState();
}

class _ReflectionState extends State<Reflection>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _animation;

  final PageController _pageController =
      PageController(initialPage: 0, viewportFraction: 1.0);

  int currentPageIndex = 0;

  Timer? _timer;
  bool _isHovering = false;
  bool _isPaused = false; // Flag for pause functionality

  void startTimer() {
    if (widget.autoPlay) {
      _timer = Timer.periodic(widget.autoPlayInterval, (timer) {
        if (!_isPaused) {
          // Check if paused before page transition
          if (_pageController.page == widget.sliderList.length - 1) {
            _pageController.animateToPage(
              0,
              duration: widget.autoPlayAnimationDuration,
              curve: widget.autoPlayCurve,
            );
          } else {
            _pageController.nextPage(
              duration: widget.autoPlayAnimationDuration,
              curve: widget.autoPlayCurve,
            );
          }
        }
      });
    }

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _animation = Tween<Offset>(begin: Offset.zero, end: const Offset(0.0, -1.1))
        .animate(CurvedAnimation(
            parent: _animationController, curve: Curves.easeIn));
  }

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _animationController.dispose();
    super.dispose();
  }

  void _handleHoverEnter() {
    _animationController.forward();
    setState(() {
      _isHovering = true;
      _isPaused = true; // Pause autoplay on hover
    });
  }

  void _handleHoverExit() {
    _animationController.reverse();
    setState(() {
      _isHovering = false;
      if (widget.autoPlay) {
        // Resume autoplay on exit if enabled
        _isPaused = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: !widget.showReflection ? widget.height : widget.height * 2,
      child: PageView.builder(
        itemCount: widget.sliderList.length,
        scrollDirection: Axis.horizontal,
        physics: const AlwaysScrollableScrollPhysics(),
        controller: _pageController,
        onPageChanged: (value) {
          setState(() {
            currentPageIndex = value;
          });
        },
        itemBuilder: (context, index) {
          return ReflectionWidget(
            widget: widget,
            index: index,
            isHovering: _isHovering,
            onHover: (p0) => _handleHoverEnter(),
            onExit: (p0) => _handleHoverExit(),
            animaton: _animation,
          );
        },
      ),
    );
  }
}
