// ignore_for_file: must_be_immutable

library carousel_custom_slider;

import 'dart:async';

import 'package:carousel_custom_slider/src/advanced_carousel_slider.dart';
import 'package:carousel_custom_slider/src/auto_scrolling_wheel.dart';
import 'package:carousel_custom_slider/src/parallax.dart';
import 'package:carousel_custom_slider/src/reflection.dart';
import 'package:carousel_custom_slider/src/simple_page_widget.dart';
import 'package:carousel_custom_slider/src/transformed_3d_card_slider.dart';
import 'package:carousel_custom_slider/src/transformed_card_slider.dart';
import 'package:carousel_custom_slider/src/widget/page_view_widget.dart';
import 'package:carousel_custom_slider/transform_type.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

export 'package:smooth_page_indicator/smooth_page_indicator.dart';

export 'transform_type.dart';
export 'transform_type_3d.dart';

/// A customizable carousel widget that displays a list of images or other content
/// in a horizontally or vertically scrolling list.
///
///Example:
///
/// ```dart
/// CarouselCustomSlider(
///   sliderList: [
///     'image1.jpg',
///     'image2.jpg',
///     'image3.jpg',
///   ],
///   viewportFraction: 0.8,
///   height: 200,
///   reverse: true,
///   effect: DepthEffect(),
///   onDotClicked: (index) {
///     print('Clicked on dot $index');
///   },
/// )
/// ```
class CarouselCustomSlider extends StatefulWidget {
  /// [sliderList]: The list of images to display in the carousel.
  final List<String> sliderList;

  /// [viewportFraction]: The fraction of the viewport that each item in the carousel occupies.
  final double viewportFraction;

  /// [width]: The width of the carousel.
  final double width;

  /// [height]: The height of the carousel.
  final double height;

  /// [reverse]: Whether to reverse the order of the items in the carousel.
  final bool reverse;

  /// [scrollDirection]: The direction in which the carousel scrolls.
  final Axis scrollDirection;

  /// [alignmentPositionIndicator]: The alignment position of the indicator.
  final AlignmentGeometry alignmentPositionIndicator;

  /// [effect]: The effect to apply to the carousel items.
  /// You can use these indicators in the effect.
  /// ```dart
  /// effect : WormEffect(),
  /// effect : JumpingDotEffect(),
  /// effect : ScaleEffect(),
  /// effect : ScrollingDotsEffect(),
  /// effect : SlideEffect(),
  /// effect : ExpandingDotsEffect(),
  /// effect : SwapEffect(
  /// dotHeight: 12.0,
  ///  dotWidth: 12.0,
  ///  paintStyle: PaintingStyle.fill,
  ///  type: SwapType.yRotation,
  ///  activeDotColor: Theme.of(context).primaryColor,
  /// dotColor: Theme.of(context).colorScheme.inversePrimary,
  /// ),
  ///```

  final IndicatorEffect effect;

  /// [axisDirectionIndicator]: The axis direction of the indicator.
  final Axis axisDirectionIndicator;

  /// [textDirectionIndicator]: The text direction of the indicator.
  final TextDirection? textDirectionIndicator;

  /// [onDotClicked]: Callback function called when a dot indicator is clicked.
  final void Function(int)? onDotClicked;

  /// [viewportFractionPaddingHorizontal]: The horizontal padding between items in the carousel.
  final double viewportFractionPaddingHorizontal;

  /// [viewportFractionPaddingVertical]: The vertical padding between items in the carousel.
  final double viewportFractionPaddingVertical;

  /// [pageSnapping]: Whether to snap to each item in the carousel when scrolling.
  final bool pageSnapping;

  /// [allowImplicitScrolling]: Whether to allow implicit scrolling.
  final bool allowImplicitScrolling;

  /// [clipBehavior]: The clip behavior of the carousel.
  final Clip clipBehavior;

  /// [dragStartBehavior]: The drag start behavior of the carousel.
  final DragStartBehavior dragStartBehavior;

  /// [findChildIndexCallback]: Callback function to find the index of a child item.
  final int? Function(Key)? findChildIndexCallback;

  /// [padEnds]: Whether to pad the ends of the carousel.
  final bool padEnds;

  /// [physics]: The scroll physics of the carousel.
  final ScrollPhysics? physics;

  /// [restorationId]: The restoration ID of the carousel.
  final String? restorationId;

  /// [scrollBehavior]: The scroll behavior of the carousel.
  final ScrollBehavior? scrollBehavior;

  /// [backgroundColor]: The background color of the carousel.
  final Color backgroundColor;

  /// [isVerticalIndicator]: Whether the indicator is vertical.

  final bool isVerticalIndicator;

  /// [initialPage]: The initial page of the carousel.
  final int initialPage;

  /// [autoPlay]: Whether to automatically play the carousel.
  final bool autoPlay;

  /// [autoPlayInterval]: The interval between auto play animations.
  final Duration autoPlayInterval;

  /// [autoPlayAnimationDuration]: The duration of auto play animations.
  final Duration autoPlayAnimationDuration;

  /// [autoPlayCurve]: The curve of auto play animations.
  final Curve autoPlayCurve;

  /// [doubleTapZoom]: Whether to enable double tap zoom.
  final bool doubleTapZoom;

  /// [clipBehaviorZoom]: The clip behavior of zoom.
  final bool clipBehaviorZoom;

  /// [fitPic]: The fit of the picture.
  final BoxFit? fitPic;

  /// [isdisplayIndicator]: Whether to display the indicator.
  final bool isDisplayIndicator;

  /// [alignmentVerticalPositionIndicator]: The alignment position of the vertical position indicator.
  final AlignmentGeometry alignmentVerticalPositionIndicator;

  /// [paddingVerticalPositionIndicator]: The padding around the vertical position indicator.
  final EdgeInsetsGeometry paddingVerticalPositionIndicator;

  /// [borderRadius]: The border radius of the carousel.
  final BorderRadiusGeometry borderRadius;

  /// A builder function that returns a widget to display on top of each slide.
  ///
  /// The function receives the index of the current slide and returns a widget.
  final Widget Function(int index)? childrenStackBuilder;

  const CarouselCustomSlider({
    super.key,
    required this.sliderList,
    this.viewportFractionPaddingHorizontal = 0,
    this.viewportFractionPaddingVertical = 0,
    this.height = 350,
    this.width = double.infinity,
    this.reverse = false,
    this.viewportFraction = 1.0,
    this.scrollDirection = Axis.horizontal,
    this.alignmentPositionIndicator = Alignment.bottomCenter,
    this.onDotClicked,
    this.axisDirectionIndicator = Axis.horizontal,
    this.textDirectionIndicator = TextDirection.ltr,
    this.pageSnapping = true,
    this.allowImplicitScrolling = false,
    this.clipBehavior = Clip.hardEdge,
    this.dragStartBehavior = DragStartBehavior.start,
    this.findChildIndexCallback,
    this.padEnds = true,
    this.isDisplayIndicator = true,
    this.physics,
    this.restorationId,
    this.scrollBehavior,
    this.backgroundColor = Colors.white,
    this.isVerticalIndicator = false,
    this.initialPage = 0,
    this.autoPlay = true,
    this.autoPlayInterval = const Duration(seconds: 3),
    this.autoPlayAnimationDuration = const Duration(seconds: 1),
    this.autoPlayCurve = Curves.easeInSine,
    this.doubleTapZoom = false,
    this.clipBehaviorZoom = false,
    this.fitPic = BoxFit.cover,
    this.alignmentVerticalPositionIndicator = Alignment.centerLeft,
    this.paddingVerticalPositionIndicator =
        const EdgeInsets.symmetric(horizontal: 15.0),
    this.borderRadius = BorderRadius.zero,
    this.effect = const SlideEffect(
      dotHeight: 8,
      dotWidth: 8,
    ),
    this.childrenStackBuilder = defaultChildrenStackBuilder,
  });

  /// [autoScrollingWheel]: A widget that automatically ListWheel scrolls to the next item in a list at a specified interval.
  ///

  ///Example:
  ///
  /// ```dart
  /// autoScrollingWheel(
  ///   autoPlay: false,
  ///   height: 150,
  ///   backgroundImageUrls: listImage,
  ///   children: children,
  ///   );
  /// ```
  static Widget autoScrollingWheel({
    required final List<Widget> children,
    final Duration duration = const Duration(seconds: 3),
    final Curve curve = Curves.ease,
    final List<String>? backgroundImageUrls,
    final Color? backgroundColor,
    final double height = 200,
    final ScrollPhysics? physics,
    final double diameterRatio = RenderListWheelViewport.defaultDiameterRatio,
    final double perspective = RenderListWheelViewport.defaultPerspective,
    final double offAxisFraction = 0.0,
    final bool useMagnifier = false,
    final double magnification = 1.0,
    final double overAndUnderCenterOpacity = 1.0,
    final double squeeze = 1.0,
    final ValueChanged<int>? onSelectedItemChanged,
    final bool renderChildrenOutsideViewport = false,
    final Clip clipBehavior = Clip.hardEdge,
    final String? restorationId,
    final ScrollBehavior? scrollBehavior,
    final bool autoPlay = true,
    final Widget Function(BuildContext, Object, StackTrace?)?
        errorBuilderBackgroundImage,
  }) {
    return AutoScrollingWheel(
      autoPlay: autoPlay,
      duration: duration,
      curve: curve,
      backgroundColor: backgroundColor,
      backgroundImageUrls: backgroundImageUrls,
      clipBehavior: clipBehavior,
      diameterRatio: diameterRatio,
      height: height,
      magnification: magnification,
      offAxisFraction: offAxisFraction,
      onSelectedItemChanged: onSelectedItemChanged,
      overAndUnderCenterOpacity: overAndUnderCenterOpacity,
      perspective: perspective,
      physics: physics,
      renderChildrenOutsideViewport: renderChildrenOutsideViewport,
      restorationId: restorationId,
      scrollBehavior: scrollBehavior,
      squeeze: squeeze,
      useMagnifier: useMagnifier,
      errorBuilderBackgroundImage: errorBuilderBackgroundImage,
      children: children,
    );
  }

  ///Example:
  ///
  /// ```dart
  /// Parallax(
  ///
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
  ///   "Parallax",
  ///   style: TextStyle(color: Colors.white, fontSize: 30.0),
  ///   ),
  ///   )
  ///   ],
  /// )
  /// ```

  static Widget parallax({
    /// The list of image URLs for the background image of each card.
    required final List<String> imageUrl,

    /// The elevation of the card, which creates a shadow effect. Defaults to 0.0.
    final double elevation = 0.0,

    /// The color of the shadow. Defaults to black.
    final Color? shadowColor = Colors.black,

    /// Determines whether to show the background image on the card. Defaults to true.
    final bool showBackgroundImage = true,

    /// The background color of the card. Defaults to white.
    final Color backgroundColor = Colors.white,

    /// The blur value for the background image. Defaults to 10.0.
    final double sigmaXBlurBackgroundImage = 10.0,

    /// The initial page to be displayed in the card slider. Defaults to 1.
    final int initialPage = 1,

    /// The fraction of the viewport occupied by each card in the slider. Defaults to 0.5.
    final double viewportFraction = 0.5,

    /// Callback function when the card is tapped.
    final void Function()? onTap,

    /// Callback function when the card is double-tapped.
    final void Function()? onDoubleTap,

    /// Callback function when the card is long-pressed.
    final void Function()? onLongPress,

    /// The duration of the animation when transitioning between cards. Defaults to 700 microseconds.
    final Duration duration = const Duration(milliseconds: 700),

    /// The border radius of the card.
    final BorderRadiusGeometry? borderRadius = BorderRadius.zero,

    /// The border of the card.
    final BoxBorder? border,

    /// The background color of the card.
    final Color cardBackgroundColor = Colors.white70,

    /// A builder function to customize the error widget.
    final Widget Function(BuildContext, Object, StackTrace?)? errorBuilder,

    /// A builder function to customize the frame of the card.
    final Widget Function(BuildContext, Widget, int?, bool)? frameBuilder,

    /// The height of the cached image.
    final int? cacheHeight = 1200,

    /// The width of the cached image.
    final int? cacheWidth = 1200,

    /// The scaling factor for the image value. Defaults to 0.5.
    final double valueScalingFactor = 0.5,

    /// The dynamic height of the card. Defaults to 400.
    final int dynamicHeight = 400,

    /// The horizontal transform of the card. Defaults to 250.
    final int horizontalTransform = 250,

    /// The title text displayed on the card.
    final String? title,

    /// The explicit height of the card.
    final double? height,

    /// The explicit width of the card.
    final double? width,

    /// The custom curve used for controlling the animation transition in the carousel.
    ///
    /// This curve defines the rate of change of an animation over time. The curve
    /// determines how the animation progresses from its initial state to its final
    /// state. By providing a custom curve, you can create unique animation effects
    /// with different rates of change.
    ///
    /// The [customCurve] can be any valid [Curve] instance from the Flutter framework,
    /// such as linear, easeIn, easeOut, cubic, etc.
    final Curve customCurve = Curves.ease,

    /// The text direction of the displayed widget.
    final TextDirection directionality = TextDirection.ltr,

    /// The filter quality for widget images.
    final FilterQuality filterQuality = FilterQuality.low,

    /// A builder function that returns a widget to display on top of each slide.
    ///
    /// The function receives the index of the current slide and returns a widget.
    final Widget Function(int index)? childrenStackBuilder =
        defaultChildrenStackBuilder,
  }) {
    return Parallax(
      imageUrl: imageUrl,
      elevation: elevation,
      shadowColor: shadowColor,
      showBackgroundImage: showBackgroundImage,
      backgroundColor: backgroundColor,
      sigmaXBlurBackgroundImage: sigmaXBlurBackgroundImage,
      initialPage: initialPage,
      viewportFraction: viewportFraction,
      onTap: onTap,
      onDoubleTap: onDoubleTap,
      onLongPress: onLongPress,
      duration: duration,
      borderRadius: borderRadius,
      border: border,
      cardBackgroundColor: cardBackgroundColor,
      errorBuilder: errorBuilder,
      frameBuilder: frameBuilder,
      cacheHeight: cacheHeight,
      cacheWidth: cacheWidth,
      valueScalingFactor: valueScalingFactor,
      dynamicHeight: dynamicHeight,
      horizontalTransform: horizontalTransform,
      height: height,
      width: width,
      customCurve: customCurve,
      directionality: directionality,
      filterQuality: filterQuality,
      childrenStackBuilder: childrenStackBuilder,
    );
  }

  ///Example:
  ///
  /// ```dart
  /// SimplePageWidget(
  ///
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
  ///   "Hello",
  ///   style: TextStyle(color: Colors.white, fontSize: 30.0),
  ///   ),
  ///   )
  ///   ],
  /// )
  /// ```

  static Widget customCardSimple({
    /// The list of image URLs for the background image of each card.
    required final List<String> imageUrl,

    /// The elevation of the card, which creates a shadow effect. Defaults to 0.0.
    final double elevation = 0.0,

    /// The color of the shadow. Defaults to black.
    final Color? shadowColor = Colors.black,

    /// Determines whether to show the background image on the card. Defaults to true.
    final bool showBackgroundImage = true,

    /// The background color of the card. Defaults to white.
    final Color backgroundColor = Colors.white,

    /// The blur value for the background image. Defaults to 10.0.
    final double sigmaXBlurBackgroundImage = 10.0,

    /// The initial page to be displayed in the card slider. Defaults to 1.
    final int initialPage = 1,

    /// The fraction of the viewport occupied by each card in the slider. Defaults to 0.5.
    final double viewportFraction = 0.5,

    /// Callback function when the card is tapped.
    final void Function()? onTap,

    /// Callback function when the card is double-tapped.
    final void Function()? onDoubleTap,

    /// Callback function when the card is long-pressed.
    final void Function()? onLongPress,

    /// The duration of the animation when transitioning between cards. Defaults to 700 microseconds.
    final Duration duration = const Duration(milliseconds: 700),

    /// The border radius of the card.
    final BorderRadiusGeometry? borderRadius = BorderRadius.zero,

    /// The border of the card.
    final BoxBorder? border,

    /// The background color of the card.
    final Color cardBackgroundColor = Colors.white70,

    /// A builder function to customize the error widget.
    final Widget Function(BuildContext, Object, StackTrace?)? errorBuilder,

    /// A builder function to customize the frame of the card.
    final Widget Function(BuildContext, Widget, int?, bool)? frameBuilder,

    /// The height of the cached image.
    final int? cacheHeight = 1200,

    /// The width of the cached image.
    final int? cacheWidth = 1200,

    /// The scaling factor for the image value. Defaults to 0.5.
    final double valueScalingFactor = 0.5,

    /// The dynamic height of the card. Defaults to 400.
    final int dynamicHeight = 400,

    /// The horizontal transform of the card. Defaults to 250.
    final int horizontalTransform = 250,

    /// The explicit height of the card.
    final double? height,

    /// The explicit width of the card.
    final double? width,

    /// The custom curve used for controlling the animation transition in the carousel.
    ///
    /// This curve defines the rate of change of an animation over time. The curve
    /// determines how the animation progresses from its initial state to its final
    /// state. By providing a custom curve, you can create unique animation effects
    /// with different rates of change.
    ///
    /// The [customCurve] can be any valid [Curve] instance from the Flutter framework,
    /// such as linear, easeIn, easeOut, cubic, etc.
    final Curve customCurve = Curves.easeInOutCubic,

    /// The text direction of the displayed widget.
    final TextDirection directionality = TextDirection.ltr,

    /// The filter quality for widget images.
    final FilterQuality filterQuality = FilterQuality.low,

    /// The fit property of the image widget.
    final BoxFit? fit = BoxFit.fitHeight,

    /// A builder function that returns a widget to display on top of each slide.
    ///
    /// The function receives the index of the current slide and returns a widget.
    final List<Widget> Function(int index)? childrenStackBuilder,
  }) {
    return SimplePageWidget(
      imageUrl: imageUrl,
      elevation: elevation,
      shadowColor: shadowColor,
      showBackgroundImage: showBackgroundImage,
      backgroundColor: backgroundColor,
      sigmaXBlurBackgroundImage: sigmaXBlurBackgroundImage,
      initialPage: initialPage,
      viewportFraction: viewportFraction,
      onTap: onTap,
      onDoubleTap: onDoubleTap,
      onLongPress: onLongPress,
      duration: duration,
      borderRadius: borderRadius,
      border: border,
      cardBackgroundColor: cardBackgroundColor,
      errorBuilder: errorBuilder,
      frameBuilder: frameBuilder,
      cacheHeight: cacheHeight,
      cacheWidth: cacheWidth,
      valueScalingFactor: valueScalingFactor,
      dynamicHeight: dynamicHeight,
      horizontalTransform: horizontalTransform,
      height: height,
      width: width,
      customCurve: customCurve,
      directionality: directionality,
      filterQuality: filterQuality,
      fit: fit,
      childrenStackBuilder: childrenStackBuilder,
    );
  }

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

  static Widget transFormedCardSlider({
    /// The list of image URLs for the background image of each card.
    required final List<String> imageUrl,

    /// The elevation of the card, which creates a shadow effect. Defaults to 0.0.
    final double elevation = 0.0,

    /// The color of the shadow. Defaults to black.
    final Color? shadowColor = Colors.black,

    /// Determines whether to show the background image on the card. Defaults to true.
    final bool showBackgroundImage = true,

    /// The background color of the card. Defaults to white.
    final Color backgroundColor = Colors.white,

    /// The blur value for the background image. Defaults to 10.0.
    final double sigmaXBlurBackgroundImage = 10.0,

    /// The initial page to be displayed in the card slider. Defaults to 1.
    final int initialPage = 1,

    /// The fraction of the viewport occupied by each card in the slider. Defaults to 0.5.
    final double viewportFraction = 0.5,

    /// Callback function when the card is tapped.
    final void Function()? onTap,

    /// Callback function when the card is double-tapped.
    final void Function()? onDoubleTap,

    /// Callback function when the card is long-pressed.
    final void Function()? onLongPress,

    /// The duration of the animation when transitioning between cards. Defaults to 700 microseconds.
    final Duration duration = const Duration(milliseconds: 700),

    /// The border radius of the card.
    final BorderRadiusGeometry? borderRadius = BorderRadius.zero,

    /// The border of the card.
    final BoxBorder? border,

    /// The background color of the card.
    final Color cardBackgroundColor = Colors.white70,

    /// A builder function to customize the error widget.
    final Widget Function(BuildContext, Object, StackTrace?)? errorBuilder,

    /// A builder function to customize the frame of the card.
    final Widget Function(BuildContext, Widget, int?, bool)? frameBuilder,

    /// The height of the cached image.
    final int? cacheHeight = 1200,

    /// The width of the cached image.
    final int? cacheWidth = 1200,

    /// The scaling factor for the image value. Defaults to 0.5.
    final double valueScalingFactor = 0.5,

    /// The dynamic height of the card. Defaults to 400.
    final int dynamicHeight = 400,

    /// The horizontal transform of the card. Defaults to 250.
    final int horizontalTransform = 250,

    /// The explicit height of the card.
    final double? height,

    /// The explicit width of the card.
    final double? width,

    /// The custom curve used for controlling the animation transition in the carousel.
    ///
    /// This curve defines the rate of change of an animation over time. The curve
    /// determines how the animation progresses from its initial state to its final
    /// state. By providing a custom curve, you can create unique animation effects
    /// with different rates of change.
    ///
    /// The [customCurve] can be any valid [Curve] instance from the Flutter framework,
    /// such as linear, easeIn, easeOut, cubic, etc.
    final Curve customCurve = Curves.easeInOutCubic,

    /// The text direction of the displayed widget.
    final TextDirection directionality = TextDirection.ltr,

    /// The filter quality for widget images.
    final FilterQuality filterQuality = FilterQuality.low,

    /// The fit property of the image widget.
    final BoxFit? fit = BoxFit.fitHeight,

    /// The transform type of the card. Defaults to [TransformType.skew].
    final TransformType transformType = TransformType.skew,

    /// A builder function that returns a widget to display on top of each slide.
    ///
    /// The function receives the index of the current slide and returns a widget.
    final List<Widget> Function(int index)? childrenStackBuilder =
        defaultChildrenStackBuilders,
  }) {
    return TransformedCardSlider(
      imageUrl: imageUrl,
      elevation: elevation,
      shadowColor: shadowColor,
      showBackgroundImage: showBackgroundImage,
      backgroundColor: backgroundColor,
      sigmaXBlurBackgroundImage: sigmaXBlurBackgroundImage,
      initialPage: initialPage,
      viewportFraction: viewportFraction,
      onTap: onTap,
      onDoubleTap: onDoubleTap,
      onLongPress: onLongPress,
      duration: duration,
      borderRadius: borderRadius,
      border: border,
      cardBackgroundColor: cardBackgroundColor,
      errorBuilder: errorBuilder,
      frameBuilder: frameBuilder,
      cacheHeight: cacheHeight,
      cacheWidth: cacheWidth,
      valueScalingFactor: valueScalingFactor,
      dynamicHeight: dynamicHeight,
      horizontalTransform: horizontalTransform,
      height: height,
      width: width,
      customCurve: customCurve,
      directionality: directionality,
      filterQuality: filterQuality,
      fit: fit,
      transformType: transformType,
      childrenStackBuilder: childrenStackBuilder,
    );
  }

  ///Example:
  ///
  /// ```dart
  /// transformed3DCardlider(
  ///   transformType: TransformType.identity,
  ///   imageUrl: [
  ///     'image1.jpg',
  ///     'image2.jpg',
  ///     'image3.jpg',
  ///   ],
  ///   showBackgroundImage: false,
  ///   viewportFraction: 0.8,
  ///   borderRadius: BorderRadius.circular(16.0),
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

  static Widget transformed3DCardlider({
    /// The list of image URLs for the background image of each card.
    required final List<String> imageUrl,

    /// The text direction of the displayed widget.
    final TextDirection directionality = TextDirection.ltr,

    /// The initial page to be displayed in the card slider. Defaults to 1.
    final int initialPage = 1,

    /// The fraction of the viewport occupied by each card in the slider. Defaults to 0.8.
    final double viewportFraction = 0.8,

    /// The explicit height of the box.
    final double? height,

    /// The explicit width of the box.
    final double? width,

    /// The explicit height of the card. Defaults to 400.
    final double? heightCard = 400,

    /// The explicit width of the card.
    final double? widthCard,

    /// Callback function when the card is tapped.
    final void Function()? onTap,

    /// Callback function when the card is double-tapped.
    final void Function()? onDoubleTap,

    /// Callback function when the card is long-pressed.
    final void Function()? onLongPress,

    /// The background color of the card.
    final Color cardBackgroundColor = Colors.white,

    /// A builder function to customize the error widget.
    final Widget Function(BuildContext, Object, StackTrace?)? errorBuilder,

    /// A builder function to customize the frame of the card.
    final Widget Function(BuildContext, Widget, int?, bool)? frameBuilder,

    /// The height of the cached image.
    final int? cacheHeight = 300,

    /// The width of the cached image.
    final int? cacheWidth = 300,

    /// Determines whether to show the background image on the card. Defaults to true.
    final bool showBackgroundImage = true,

    /// The blur value for the background image. Defaults to 10.0.
    final double sigmaXBlurBackgroundImage = 10.0,

    /// The fit property of the image widget.
    final BoxFit? fit = BoxFit.fitHeight,

    /// The background color of the card. Defaults to white.
    final Color backgroundColor = Colors.white,

    /// The transform type of the card. Defaults to [TransformType.identity].
    final TransformType3d transformType3d = TransformType3d.identity,

    /// A builder function that returns a widget to display on top of each slide.
    ///
    /// The function receives the index of the current slide and returns a widget.
    final Widget Function(int index)? childrenStackBuilder =
        defaultChildrenStackBuilder,
  }) {
    return Transformed3DCardlider(
      imageUrl: imageUrl,
      directionality: directionality,
      initialPage: initialPage,
      viewportFraction: viewportFraction,
      height: height,
      width: width,
      heightCard: heightCard,
      widthCard: widthCard,
      onTap: onTap,
      onDoubleTap: onDoubleTap,
      onLongPress: onLongPress,
      cardBackgroundColor: cardBackgroundColor,
      errorBuilder: errorBuilder,
      frameBuilder: frameBuilder,
      cacheHeight: cacheHeight,
      cacheWidth: cacheWidth,
      showBackgroundImage: showBackgroundImage,
      backgroundColor: backgroundColor,
      sigmaXBlurBackgroundImage: sigmaXBlurBackgroundImage,
      fit: fit,
      transformType3d: transformType3d,
      childrenStackBuilder: childrenStackBuilder,
    );
  }

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
  ///   childrenStackBuilder : [],
  /// ```

  static Widget reflection({
    /// [sliderList]: The list of images to display.
    required final List sliderList,

    /// [width]: The width of the image.
    required final double width,

    /// [height]: The height of the image.
    required final double height,

    /// [autoPlay]: Whether to automatically play the carousel.
    final bool autoPlay = true,

    /// [autoPlayInterval]: The interval between auto play animations.
    final Duration autoPlayInterval = const Duration(seconds: 5),

    /// [autoPlayAnimationDuration]: The duration of auto play animations.
    final Duration autoPlayAnimationDuration = const Duration(seconds: 2),

    /// [autoPlayCurve]: The curve of auto play animations.
    final Curve autoPlayCurve = Curves.ease,

    /// [shadowColorStart]: The color of the shadow.
    final Color shadowColorStart = const Color.fromRGBO(0, 0, 0, 0.4),

    /// [shadowColorEnd]: The color of the shadow.
    final Color shadowColorEnd = const Color.fromRGBO(0, 0, 0, 0.9),

    /// [reflectionOpacity]: The opacity of the reflection. Defaults to 0.4. between 0.0 and 1.0
    final double reflectionOpacity = 0.4,

    /// [reflectionBlendMode]: The blend mode of the reflection . Defaults BlendMode.xor.
    final BlendMode reflectionBlendMode = BlendMode.dst,

    /// [cacheHeight]: The height of the cache.
    final int cacheHeight = 200,

    /// [cacheWidth]: The width of the cache.
    final int cacheWidth = 200,

    /// [fit]: The fit of the image.
    final BoxFit? fit = BoxFit.fill,

    /// [onTap]: The callback when the image is tapped.
    final void Function()? onTap,

    /// [errorBuilder]: The error builde ImageBuilder.
    final Widget Function(BuildContext, Object, StackTrace?)? errorBuilder,

    /// [borderColor]: The color of the border.
    final Color? borderColor,

    /// [showReflection]: Whether to show the reflection.
    final bool showReflection = true,

    /// A builder function that returns a widget to display on top of each slide.
    ///
    /// The function receives the index of the current slide and returns a widget.
    final Widget? Function(int index)? childrenStackBuilder =
        AdvancedCarouselSlider.defaultChildrenStackBuilder,
  }) {
    return Reflection(
      sliderList: sliderList,
      width: width,
      height: height,
      reflectionOpacity: reflectionOpacity,
      reflectionBlendMode: reflectionBlendMode,
      shadowColorStart: shadowColorStart,
      shadowColorEnd: shadowColorEnd,
      autoPlay: autoPlay,
      autoPlayInterval: autoPlayInterval,
      autoPlayAnimationDuration: autoPlayAnimationDuration,
      autoPlayCurve: autoPlayCurve,
      cacheHeight: cacheHeight,
      cacheWidth: cacheHeight,
      childrenStackBuilder: childrenStackBuilder,
    );
  }

  /// Example usage:
  /// ```dart
  /// AdvancedCarouselSlider(
  ///   slides: [
  ///     'https://example.com/image1.jpg',
  ///     'https://example.com/image2.jpg',
  ///     // ...
  ///   ],
  ///   height: 200,
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
  /// [colorFilter] is the color filter of the carousel. Defaults to=>
  /// ```dart
  /// ColorFilter.mode(
  ///    Colors.black
  ///   .withOpacity(isCurrentPage ? 0.3 : 0.9),
  ///  BlendMode.xor,
  /// ),
  /// ```
  static Widget advancedCarouselSlider({
    /// [slides] is a list of images or other content that will be displayed in the carousel.
    required final List<String> slides,

    /// [height] The height of the carousel. Defaults to 100. between 0.0 and 100.0 percent
    final double height = 100,

    /// [width] The width of the carousel. Defaults to 100. between 0.0 and 100.0 percent.
    final double width = 100,

    /// [viewportFraction] is the fraction of the viewport that each card occupies.
    final double viewportFraction = 1.0,

    /// [directionality] is the text direction of the carousel.
    final TextDirection directionality = TextDirection.ltr,

    /// [initialPage] is the initial page to display. Defaults to 1.
    final int initialPage = 1,

    /// [backgroundColor] is the background color of the carousel.
    final Color backgroundColor = Colors.black,

    /// [fit] is the fit of the carousel.
    final BoxFit fit = BoxFit.cover,

    /// [colorFilter] is the color filter of the carousel. Defaults to=>
    /// ```dart
    /// ColorFilter.mode(
    ///    Colors.black
    ///   .withOpacity(isCurrentPage ? 0.3 : 0.9),
    ///  BlendMode.xor,
    /// ),
    /// ```
    final ColorFilter? colorFilter,

    /// The direction in which the carousel scrolls.
    final Axis scrollDirection = Axis.horizontal,

    /// The alignment position of the indicator.
    final AlignmentGeometry alignmentPositionIndicator = Alignment.bottomCenter,

    /// Whether to display the indicator.
    final bool isDisplayIndicator = true,

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
    final IndicatorEffect effect = const SlideEffect(
      dotHeight: 8,
      dotWidth: 8,
    ),

    /// The axis direction of the indicator.
    final Axis axisDirectionIndicator = Axis.horizontal,

    /// The text direction of the indicator.
    final TextDirection? textDirectionIndicator,

    /// Callback function called when a dot indicator is clicked.
    final void Function(int)? onDotClicked,

    /// The height of the cache image.
    final int? cacheHeigh = 300,

    /// The width of the cache image.
    final int? cacheWidth = 300,

    /// A builder function that returns a widget to display on top of each slide.
    ///
    /// The function receives the index of the current slide and returns a widget.
    final Widget? Function(int index) childrenStackBuilder =
        AdvancedCarouselSlider.defaultChildrenStackBuilder,
  }) {
    return AdvancedCarouselSlider(
      slides: slides,
      height: height,
      width: width,
      viewportFraction: viewportFraction,
      scrollDirection: scrollDirection,
      alignmentPositionIndicator: alignmentPositionIndicator,
      axisDirectionIndicator: scrollDirection,
      backgroundColor: backgroundColor,
      directionality: directionality,
      fit: fit,
      onDotClicked: onDotClicked,
      textDirectionIndicator: textDirectionIndicator,
      colorFilter: colorFilter,
      initialPage: initialPage,
      effect: effect,
      isDisplayIndicator: isDisplayIndicator,
      cacheHeigh: cacheHeigh,
      cacheWidth: cacheWidth,
      childrenStackBuilder: childrenStackBuilder,
    );
  }

  static Widget defaultChildrenStackBuilder(int index) =>
      const SizedBox.shrink();

  static List<Widget> defaultChildrenStackBuilders(int index) => [];

  @override
  State<CarouselCustomSlider> createState() => _CarouselCustomSliderState();
}

class _CarouselCustomSliderState extends State<CarouselCustomSlider> {
  /// PageView
  late List<Widget> _pageList;

  int currentPageIndex = 0;

  /// PageController
  late final PageController _pageController = PageController(
    initialPage: widget.initialPage,
    viewportFraction: widget.viewportFraction,
  );

  /// Timer for auto play
  Timer? _timer;

  /// Start timer
  void startTimer() {
    if (widget.autoPlay) {
      // Only start timer if autoplay is enabled
      _timer = Timer.periodic(widget.autoPlayInterval, (timer) {
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
      });
    }
  }

  @override
  void initState() {
    super.initState();

    _pageList = List.generate(
      widget.sliderList.length,
      (index) => PageViewWidget(
        widget: widget,
        index: index,
      ),
    );
    startTimer();
  }

  /// Dispose timer
  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      color: widget.backgroundColor,
      child: Stack(
        children: [
          PageView.builder(
            pageSnapping: widget.pageSnapping,
            allowImplicitScrolling: widget.allowImplicitScrolling,
            clipBehavior: widget.clipBehavior,
            dragStartBehavior: widget.dragStartBehavior,
            findChildIndexCallback: widget.findChildIndexCallback,
            padEnds: widget.padEnds,
            physics: widget.physics,
            restorationId: widget.restorationId,
            scrollBehavior: widget.scrollBehavior,
            controller: _pageController, // Use PageController
            itemCount: widget.sliderList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: widget.viewportFractionPaddingHorizontal,
                  vertical: widget.viewportFractionPaddingVertical,
                ),
                child: ClipRRect(
                  borderRadius: widget.borderRadius,
                  child: _pageList[index],
                ),
              );
            },
            onPageChanged: (value) {
              setState(() {
                currentPageIndex = value;
              });
            }, // Update current page on change
            reverse: widget.reverse,
            scrollDirection: widget.scrollDirection,
          ),
          if (widget.isDisplayIndicator)
            widget.isVerticalIndicator
                ? Padding(
                    padding: widget.paddingVerticalPositionIndicator,
                    child: Align(
                      alignment: widget.alignmentVerticalPositionIndicator,
                      child: RotatedBox(
                        quarterTurns: 3,
                        child: SmoothPageIndicator(
                          controller: _pageController,
                          count: widget.sliderList.length,
                          effect: widget.effect,
                          axisDirection: widget.axisDirectionIndicator,
                          textDirection: widget.textDirectionIndicator,
                          onDotClicked: widget.onDotClicked,
                        ),
                      ),
                    ),
                  )
                : Align(
                    alignment: widget.alignmentPositionIndicator,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: SmoothPageIndicator(
                        controller: _pageController,
                        count: widget.sliderList.length,
                        effect: widget.effect,
                        axisDirection: widget.axisDirectionIndicator,
                        textDirection: widget.textDirectionIndicator,
                        onDotClicked: widget.onDotClicked,
                      ),
                    ),
                  )
          else
            const SizedBox.shrink(),
        ],
      ),
    );
  }
}
