// ignore_for_file: file_names

import 'package:carousel_custom_slider/src/parallax.dart';
import 'package:flutter/material.dart';

class CustomCardWidget extends StatefulWidget {
  final Parallax widget;
  final int index;
  final PageController pageController;
  const CustomCardWidget({
    super.key,
    required this.index,
    required this.pageController,
    required this.widget,
  });

  @override
  State<CustomCardWidget> createState() => _CustomCardWidgetState();
}

class _CustomCardWidgetState extends State<CustomCardWidget> {
  final imageKey = GlobalKey();
  double offset = 0;

  @override
  void initState() {
    super.initState();
    // Add listener to page controller
    widget.pageController.addListener(_pageControllerListener);
  }

  @override
  void dispose() {
    // Remove listener from page controller
    widget.pageController.removeListener(_pageControllerListener);
    super.dispose();
  }

  // Listener for page controller
  void _pageControllerListener() {
    if (mounted) {
      setState(() {
        offset = widget.pageController.page!;
      });
    }
  }

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
      child: Transform.scale(
        scale: 1,
        child: Material(
          borderRadius: widget.widget.borderRadius,
          type: MaterialType.card,
          elevation: widget.widget.elevation,
          shadowColor: widget.widget.shadowColor,
          color: Colors.transparent,
          child: Stack(
            children: [
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: widget.widget.borderRadius,
                  border: widget.widget.border,
                  color: widget.widget.cardBackgroundColor,
                ),
                child: ClipRRect(
                  borderRadius: widget.widget.borderRadius!,
                  child: Image.network(
                    widget.widget.imageUrl[widget.index],
                    height: double.infinity,
                    width: double.infinity,
                    fit: BoxFit.fitHeight,
                    cacheHeight: widget.widget.cacheHeight,
                    cacheWidth: widget.widget.cacheWidth,
                    errorBuilder: widget.widget.errorBuilder,
                    frameBuilder: widget.widget.frameBuilder,
                    alignment: Alignment(-offset.abs() + widget.index, 0),
                    filterQuality: widget.widget.filterQuality,
                  ),
                ),
              ),
              if (widget.widget.childrenStackBuilder != null)
                widget.widget.childrenStackBuilder!(widget.index),
            ],
          ),
        ),
      ),
    );
  }
}
