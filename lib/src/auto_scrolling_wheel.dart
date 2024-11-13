// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// A widget that automatically scrolls to the next item in a list at a specified interval.
class AutoScrollingWheel extends StatefulWidget {
  /// The list of widgets to be displayed in the wheel.
  final List<Widget> children;

  /// The duration of each cycle in the scrolling wheel.
  final Duration duration;

  /// The curve defining the acceleration or deceleration of the scrolling motion.
  final Curve curve;

  /// Optional list of background image URLs for each cycle.
  final List<String>? backgroundImageUrls;

  /// Background color of the scrolling wheel.
  final Color? backgroundColor;

  /// Size of each child in the main axis.
  ///
  /// Must be positive.
  final double height;

  /// How the scroll view should respond to user input.
  ///
  /// For example, determines how the scroll view continues to animate after the
  /// user stops dragging the scroll view.
  ///
  /// If an explicit [ScrollBehavior] is provided to [scrollBehavior], the
  /// [ScrollPhysics] provided by that behavior will take precedence after
  /// [physics].
  ///
  /// Defaults to matching platform conventions.
  final ScrollPhysics? physics;

  /// {@macro flutter.rendering.RenderListWheelViewport.diameterRatio}
  final double diameterRatio;

  /// {@macro flutter.rendering.RenderListWheelViewport.perspective}
  final double perspective;

  /// {@macro flutter.rendering.RenderListWheelViewport.offAxisFraction}
  final double offAxisFraction;

  /// {@macro flutter.rendering.RenderListWheelViewport.useMagnifier}
  final bool useMagnifier;

  /// {@macro flutter.rendering.RenderListWheelViewport.magnification}
  final double magnification;

  /// {@macro flutter.rendering.RenderListWheelViewport.overAndUnderCenterOpacity}
  final double overAndUnderCenterOpacity;

  /// {@macro flutter.rendering.RenderListWheelViewport.squeeze}
  ///
  /// Defaults to 1.
  final double squeeze;

  /// On optional listener that's called when the centered item changes.
  final ValueChanged<int>? onSelectedItemChanged;

  /// {@macro flutter.rendering.RenderListWheelViewport.renderChildrenOutsideViewport}
  final bool renderChildrenOutsideViewport;

  /// {@macro flutter.material.Material.clipBehavior}
  ///
  /// Defaults to [Clip.hardEdge].
  final Clip clipBehavior;

  /// {@macro flutter.widgets.scrollable.restorationId}
  final String? restorationId;

  /// {@macro flutter.widgets.shadow.scrollBehavior}
  ///
  /// [ScrollBehavior]s also provide [ScrollPhysics]. If an explicit
  /// [ScrollPhysics] is provided in [physics], it will take precedence,
  /// followed by [scrollBehavior], and then the inherited ancestor
  /// [ScrollBehavior].
  ///
  /// The [ScrollBehavior] of the inherited [ScrollConfiguration] will be
  /// modified by default to not apply a [Scrollbar].
  final ScrollBehavior? scrollBehavior;

  /// Automatically scrolls to the next item in the list.
  final bool autoPlay;

  /// Background scroll direction.
  final Axis backgroundScrollDirection = Axis.horizontal;

  /// Background blur image
  final double backgroundBlurImage;

  /// Background image fit
  final BoxFit? fitBackgroundImage;

  final Widget Function(BuildContext, Object, StackTrace?)?
      errorBuilderBackgroundImage;

  const AutoScrollingWheel({
    super.key,
    required this.children,
    this.duration = const Duration(seconds: 3),
    this.curve = Curves.ease,
    this.backgroundImageUrls,
    this.backgroundColor = Colors.transparent,
    this.height = 200,
    this.onSelectedItemChanged,
    this.physics,
    this.diameterRatio = RenderListWheelViewport.defaultDiameterRatio,
    this.perspective = RenderListWheelViewport.defaultPerspective,
    this.offAxisFraction = 0.0,
    this.useMagnifier = false,
    this.magnification = 1.0,
    this.overAndUnderCenterOpacity = 1.0,
    this.squeeze = 1.0,
    this.renderChildrenOutsideViewport = false,
    this.clipBehavior = Clip.hardEdge,
    this.restorationId,
    this.scrollBehavior,
    this.autoPlay = true,
    this.backgroundBlurImage = 8.0,
    this.fitBackgroundImage = BoxFit.cover,
    this.errorBuilderBackgroundImage,
  });

  @override
  State<AutoScrollingWheel> createState() => _AutoScrollingWheelState();
}

class _AutoScrollingWheelState extends State<AutoScrollingWheel> {
  late Timer _scrollingTimer;
  late FixedExtentScrollController _scrollerController;
  late PageController _pageController;
  int curentIndex = 0;

  @override
  void initState() {
    super.initState();
    _scrollingTimer = Timer(Duration.zero, () {});

    _scrollerController = FixedExtentScrollController();

    _pageController = PageController(
      initialPage: 0,
      viewportFraction: 1.0,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollerController.hasClients) {
        _startScrolling();
      }
    });

    _scrollerController.addListener(() {
      final currentIndex = _scrollerController.selectedItem;
      _pageController.jumpToPage(currentIndex);
    });
  }

  @override
  void dispose() {
    _scrollingTimer.cancel();
    super.dispose();
  }

  void _startScrolling() {
    if (widget.autoPlay) {
      _scrollingTimer = Timer.periodic(widget.duration, (timer) {
        final currentIndex = _scrollerController.selectedItem;
        final nextIndex = (currentIndex + 1) % widget.children.length;

        // Animate to the next index (looping back to the first when at the end)
        _pageController.animateToPage(
          nextIndex,
          duration: const Duration(seconds: 1),
          curve: widget.curve,
        );

        _scrollerController.animateToItem(
          nextIndex,
          duration: const Duration(seconds: 1),
          curve: widget.curve,
        );
      });
    } else {
      // Initialize a dummy timer when autoPlay is false
      _scrollingTimer = Timer(Duration.zero, () {});
      _pageController.animateToPage(
        _scrollerController.selectedItem,
        duration: const Duration(seconds: 1),
        curve: widget.curve,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final backgroundImageCount = widget.backgroundImageUrls?.length ?? 0;
    final childrenCount = widget.children.length;

    // Ensure background images match children count (repeat if necessary)
    final backgroundImages = List.generate(
      childrenCount,
      (index) => widget.backgroundImageUrls != null
          ? widget.backgroundImageUrls![index % backgroundImageCount]
          : null,
    );

    return Scaffold(
      backgroundColor: widget.backgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            widget.backgroundImageUrls == null
                ? const SizedBox.shrink()
                : SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: PageView.builder(
                      controller: _pageController,
                      scrollDirection: widget.backgroundScrollDirection,
                      itemCount: childrenCount,
                      itemBuilder: (context, index) {
                        return ImageFiltered(
                          imageFilter: ImageFilter.blur(
                            sigmaX: widget.backgroundBlurImage,
                            sigmaY: widget.backgroundBlurImage,
                            tileMode: TileMode.repeated,
                          ),
                          child: Image.network(backgroundImages[index]!,
                              height: MediaQuery.of(context).size.height,
                              width: MediaQuery.of(context).size.width,
                              fit: widget.fitBackgroundImage,
                              alignment: Alignment.center,
                              errorBuilder: widget.errorBuilderBackgroundImage),
                        );
                      },
                    ),
                  ),
            ListWheelScrollView.useDelegate(
              onSelectedItemChanged: widget.onSelectedItemChanged,
              physics: widget.physics,
              diameterRatio: widget.diameterRatio,
              perspective: widget.perspective,
              offAxisFraction: widget.offAxisFraction,
              useMagnifier: widget.useMagnifier,
              magnification: widget.magnification,
              overAndUnderCenterOpacity: widget.overAndUnderCenterOpacity,
              squeeze: widget.squeeze,
              renderChildrenOutsideViewport:
                  widget.renderChildrenOutsideViewport,
              clipBehavior: widget.clipBehavior,
              restorationId: widget.restorationId,
              scrollBehavior: widget.scrollBehavior,
              controller: _scrollerController,
              itemExtent: widget.height,
              childDelegate: ListWheelChildBuilderDelegate(
                builder: (context, index) {
                  final actualIndex = index % widget.children.length;
                  return widget.children[actualIndex];
                },
                childCount: widget.children.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
