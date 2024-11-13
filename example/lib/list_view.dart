import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';

class WheelPageView extends StatefulWidget {
  final List<Widget> children;
  final Duration duration; // Duration for automatic scrolling
  final Curve curve; // Curve for animation (e.g., Curves.easeInOut)
  final List<String>? imageUrls;

  const WheelPageView({
    super.key,
    required this.children,
    this.duration = const Duration(seconds: 3),
    this.curve = Curves.ease,
    this.imageUrls,
  });

  @override
  State<WheelPageView> createState() => _WheelPageViewState();
}

class _WheelPageViewState extends State<WheelPageView> {
  late Timer _scrollingTimer;
  late FixedExtentScrollController _scrollerController;

  @override
  void initState() {
    super.initState();

    _scrollerController = FixedExtentScrollController();

    _startScrolling();
  }

  @override
  void dispose() {
    _scrollingTimer.cancel();
    super.dispose();
  }

  void _startScrolling() {
    _scrollingTimer = Timer.periodic(widget.duration, (timer) {
      final nextIndex = _scrollerController.selectedItem + 1;
      _scrollerController.animateToItem(
        nextIndex,
        duration: const Duration(seconds: 1),
        curve: widget.curve,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            ImageFiltered(
                imageFilter: ImageFilter.blur(
                  sigmaX: 5,
                  sigmaY: 5,
                  tileMode: TileMode.repeated,
                ),
                child: Image.network(widget.imageUrls![0])),
            ListWheelScrollView.useDelegate(
              controller: _scrollerController,
              itemExtent: 200,
              childDelegate: ListWheelChildBuilderDelegate(
                builder: (context, index) {
                  final actualIndex =
                      (index + _scrollerController.selectedItem) %
                          widget.children.length;
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
