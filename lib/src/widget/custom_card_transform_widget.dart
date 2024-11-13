// ignore_for_file: unnecessary_null_comparison

import 'package:carousel_custom_slider/src/transformed_card_slider.dart';
import 'package:carousel_custom_slider/transform_type.dart';
import 'package:flutter/material.dart';

class CustomCardTransformWidget extends StatefulWidget {
  final TransformedCardSlider widget;
  final int index;
  final PageController pageController;
  final int imageOffset;
  const CustomCardTransformWidget({
    super.key,
    required this.index,
    required this.pageController,
    required this.widget,
    required this.imageOffset,
  });

  @override
  State<CustomCardTransformWidget> createState() =>
      _CustomCardTransformWidgetState();
}

class _CustomCardTransformWidgetState extends State<CustomCardTransformWidget> {
  final imageKey = GlobalKey();
  double imageOffset = 0.0;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.pageController,
      builder: (context, child) {
        double value = 1;

        if (widget.pageController.position.haveDimensions) {
          value = widget.pageController.page! - widget.index;
          value = (1 - (value.abs() * widget.widget.valueScalingFactor))
              .clamp(0.0, 1.0);
          double page = widget.pageController.page!;
          imageOffset =
              -(page - widget.index) * // Inverted for leftward movement
                  widget.widget.valueScalingFactor;
        }

        return Center(
          child: SizedBox(
            height: widget.widget.customCurve.transform(value) *
                widget.widget.dynamicHeight,
            width: Curves.easeInOutBack.transform(value) *
                widget.widget.horizontalTransform,
            child: child,
          ),
        );
      },
      child: Transform(
        alignment: Alignment.center,
        transform: getTransformMatrix(widget.widget.transformType),
        child: Material(
          type: MaterialType.card,
          elevation: widget.widget.elevation,
          shadowColor: widget.widget.shadowColor,
          color: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: widget.widget.borderRadius,
              color: widget.widget.cardBackgroundColor,
              border: widget.widget.border,
              image: DecorationImage(
                image: Image.network(
                  widget.widget.imageUrl[widget.index],
                  height: double.infinity,
                  width: double.infinity,
                  fit: BoxFit.fitHeight,
                  cacheHeight: 1200,
                  cacheWidth: 1200,
                  errorBuilder: widget.widget.errorBuilder,
                  frameBuilder: widget.widget.frameBuilder,
                  alignment: Alignment(imageOffset, 0.0),
                ).image,
                fit: BoxFit.fitHeight,
              ),
            ),
            child: Stack(
              children: widget.widget.childrenStackBuilder!(widget.index)
                  .where((widget) => widget != null)
                  .cast<Widget>()
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }

  Matrix4 getTransformMatrix(
    TransformType transformType,
  ) {
    switch (transformType) {
      case TransformType.skew:
        return Matrix4.skew(0.2, 0.4 * 0.2);
      case TransformType.skew1:
        return Matrix4.skew(widget.imageOffset * 0.4, 0.0);
      case TransformType.skew2:
        return Matrix4.skew(widget.imageOffset * 0.0, 0.4);
      case TransformType.rotation:
        return Matrix4.rotationZ(widget.imageOffset * 0.5);
      case TransformType.tryInvert:
        return Matrix4.tryInvert(Matrix4.skew(0.0, 0.4))!;
      case TransformType.diagonal3Values:
        return Matrix4.diagonal3Values(1 * 1.2, 0.8 * 1.0, 0.5);

      default:
        return Matrix4.identity();
    }
  }
}
