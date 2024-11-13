// ignore_for_file: file_names, library_private_types_in_public_api

import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

enum TransformType3d {
  identity,
  identity1,
  inverted,
  inverted1,
  inverted2,
  inverted3,
  inverted4,
  rotationY,
  rotationX
}

class Transformed3DCardlider extends StatefulWidget {
  /// The list of image URLs for the background image of each card.
  final List<String> imageUrl;

  /// The text direction of the displayed widget.
  final TextDirection directionality;

  /// The initial page to be displayed in the card slider. Defaults to 1.
  final int initialPage;

  /// The fraction of the viewport occupied by each card in the slider. Defaults to 0.8.
  final double viewportFraction;

  /// The explicit height of the box.
  final double? height;

  /// The explicit width of the box.
  final double? width;

  /// The explicit height of the card. Defaults to 400.
  final double? heightCard;

  /// The explicit width of the card.
  final double? widthCard;

  /// Callback function when the card is tapped.
  final void Function()? onTap;

  /// Callback function when the card is double-tapped.
  final void Function()? onDoubleTap;

  /// Callback function when the card is long-pressed.
  final void Function()? onLongPress;

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

  /// Determines whether to show the background image on the card. Defaults to true.
  final bool showBackgroundImage;

  /// The blur value for the background image. Defaults to 10.0.
  final double sigmaXBlurBackgroundImage;

  /// The fit property of the image widget.
  final BoxFit? fit;

  /// The background color of the card. Defaults to white.
  final Color backgroundColor;

  /// The transform type of the card. Defaults to [TransformType.identity].
  final TransformType3d transformType3d;

  /// A builder function that returns a widget to display on top of each slide.
  ///
  /// The function receives the index of the current slide and returns a widget.
  final Widget Function(int index)? childrenStackBuilder;

  const Transformed3DCardlider({
    super.key,
    required this.imageUrl,
    this.directionality = TextDirection.ltr,
    this.onTap,
    this.onDoubleTap,
    this.onLongPress,
    this.cardBackgroundColor = Colors.white,
    this.errorBuilder,
    this.frameBuilder,
    this.cacheHeight = 300,
    this.cacheWidth = 300,
    this.initialPage = 1,
    this.viewportFraction = 0.8,
    this.height,
    this.width,
    this.heightCard = 400,
    this.widthCard,
    this.showBackgroundImage = true,
    this.sigmaXBlurBackgroundImage = 10.0,
    this.fit = BoxFit.fitHeight,
    this.backgroundColor = Colors.white,
    this.transformType3d = TransformType3d.identity,
    this.childrenStackBuilder,
  });

  @override
  State<Transformed3DCardlider> createState() => _Transformed3DCardliderState();
}

class _Transformed3DCardliderState extends State<Transformed3DCardlider> {
  late PageController _pageController;
  double pageOffset = 0;
  double angle = 0.0;
  double _currentPage = 0;
  double value = 0.0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: widget.initialPage,
      viewportFraction: widget.viewportFraction,
    );

    _pageController.addListener(() {
      setState(() {
        pageOffset = _pageController.page ?? 0;
        _currentPage = _pageController.page ?? 0;
      });
    });
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
      body: widget.transformType3d == TransformType3d.identity
          ? GestureDetector(
              onTap: widget.onTap,
              onDoubleTap: widget.onDoubleTap,
              onLongPress: widget.onLongPress,
              child: Directionality(
                textDirection: widget.directionality,
                child: Container(
                  height: widget.height ?? size.height,
                  width: widget.width ?? size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    color: widget.cardBackgroundColor,
                  ),
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
                                      widget.imageUrl[_currentPage.toInt()],
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
                        itemCount: widget.imageUrl.length,
                        controller: _pageController,
                        onPageChanged: (value) {
                          setState(() {
                            _currentPage = value.toDouble();
                          });
                        },
                        itemBuilder: (context, index) {
                          double scale = max(
                              widget.viewportFraction,
                              (1 - (pageOffset - index).abs()) +
                                  widget.viewportFraction);

                          angle = (pageOffset - index).abs();

                          if (angle > 0.5) {
                            angle = 1 - angle;
                          }

                          return Container(
                            height: widget.heightCard,
                            alignment: Alignment.center,
                            padding: EdgeInsets.only(
                              right: 10,
                              left: 20,
                              top: 100 - scale * 30,
                              bottom: 50,
                            ),
                            child: Transform(
                              transform:
                                  getTransformMatrix(widget.transformType3d),
                              alignment: Alignment.center,
                              child: Stack(
                                children: <Widget>[
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(12.0),
                                    child: Image.network(
                                      widget.imageUrl[index],
                                      height: widget.heightCard,
                                      width: widget.widthCard ??
                                          MediaQuery.of(context).size.width,
                                      fit: BoxFit.fitHeight,
                                      alignment: Alignment(
                                          (pageOffset - index).abs() * 0.5, 0),
                                      errorBuilder: widget.errorBuilder,
                                      frameBuilder: widget.frameBuilder,
                                      cacheHeight: widget.cacheHeight,
                                      cacheWidth: widget.cacheWidth,
                                    ),
                                  ),
                                  widget.childrenStackBuilder!(index)
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            )
          : GestureDetector(
              onTap: widget.onTap,
              onDoubleTap: widget.onDoubleTap,
              onLongPress: widget.onLongPress,
              child: Directionality(
                textDirection: widget.directionality,
                child: Container(
                    height: widget.height ?? size.height,
                    width: widget.width ?? size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      color: widget.cardBackgroundColor,
                    ),
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
                                        widget.imageUrl[_currentPage.toInt()],
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
                          controller: _pageController,
                          itemCount: widget.imageUrl.length,
                          itemBuilder: (context, index) {
                            final percent = (_currentPage - index);
                            value = percent.clamp(0.0, 1.0);

                            double scale = max(
                                widget.viewportFraction,
                                (1 - (pageOffset - index).abs()) +
                                    widget.viewportFraction);

                            return Container(
                              height: widget.heightCard,
                              alignment: Alignment.center,
                              padding: EdgeInsets.only(
                                right: 10,
                                left: 20,
                                top: 100 - scale * 30,
                                bottom: 50,
                              ),
                              child: Transform(
                                transform:
                                    getTransformMatrix(widget.transformType3d),
                                child: Stack(
                                  children: [
                                    Image.network(
                                      height: widget.heightCard,
                                      width: widget.widthCard ??
                                          MediaQuery.of(context).size.width,
                                      widget.imageUrl[index],
                                      fit: BoxFit.fitHeight,
                                      alignment: Alignment(
                                          (pageOffset - index).abs() * 0.5, 0),
                                      errorBuilder: widget.errorBuilder,
                                      frameBuilder: widget.frameBuilder,
                                      cacheHeight: widget.cacheHeight,
                                      cacheWidth: widget.cacheWidth,
                                    ),
                                    widget.childrenStackBuilder!(index)
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    )),
              ),
            ),
    );
  }

  Matrix4 getTransformMatrix(TransformType3d transformType3d) {
    switch (transformType3d) {
      case TransformType3d.identity:
        return Matrix4.identity()
          ..setEntry(3, 2, 0.001)
          ..rotateY(angle);
      case TransformType3d.identity1:
        return Matrix4.identity()
          ..setEntry(3, 2, 0.003)
          ..rotateY(pi * value)
          ..rotateX(pi * value);
      case TransformType3d.inverted:
        return Matrix4.inverted(Matrix4.rotationX(pi * value))
          ..setEntry(3, 2, 0.001)
          ..rotateX(pi * value);
      case TransformType3d.inverted1:
        return Matrix4.inverted(Matrix4.rotationX(pi * value))
          ..setEntry(3, 2, 0.001)
          ..rotateX(pi * value)
          ..rotateY(pi * value);
      case TransformType3d.inverted2:
        return Matrix4.inverted(Matrix4.rotationX(pi * value))
          ..setEntry(3, 2, 0.001)
          ..rotateX(pi * value)
          ..rotateY(pi * value)
          ..rotateZ(pi * value);
      case TransformType3d.inverted3:
        return Matrix4.inverted(Matrix4.rotationX(pi * value))
          ..setEntry(3, 2, 0.001)
          ..rotateX(pi * value)
          ..rotateZ(pi * value);
      case TransformType3d.inverted4:
        return Matrix4.inverted(Matrix4.rotationX(pi * value))
          ..setEntry(3, 2, 0.001)
          ..rotateY(pi * value)
          ..rotateZ(pi * value);
      case TransformType3d.rotationY:
        return Matrix4.rotationY(pi * value)
          ..setEntry(3, 2, 0.001)
          ..rotateX(pi * value)
          ..rotateZ(pi * value);
      case TransformType3d.rotationX:
        return Matrix4.rotationX(pi * value)
          ..setEntry(3, 2, 0.001)
          ..rotateX(pi * value)
          ..rotateZ(pi * value);
      default:
        return Matrix4.identity();
    }
  }
}
