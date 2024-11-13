// ignore_for_file: unnecessary_null_comparison

import 'package:carousel_custom_slider/src/simple_page_widget.dart';
import 'package:flutter/material.dart';

class CustomCardSimpleWidget extends StatefulWidget {
  final SimplePageWidget widget;
  final int index;
  final PageController pageController;
  const CustomCardSimpleWidget({
    super.key,
    required this.index,
    required this.pageController,
    required this.widget,
  });

  @override
  State<CustomCardSimpleWidget> createState() => _CustomCardSimpleWidgetState();
}

class _CustomCardSimpleWidgetState extends State<CustomCardSimpleWidget> {
  final imageKey = GlobalKey();

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
                fit: widget.widget.fit,
                cacheHeight: widget.widget.cacheHeight,
                cacheWidth: widget.widget.cacheWidth,
                errorBuilder: widget.widget.errorBuilder,
                frameBuilder: widget.widget.frameBuilder,
                filterQuality: widget.widget.filterQuality,
              ).image,
              fit: widget.widget.fit,
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
    );
  }
}
