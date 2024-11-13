import 'dart:math' as math;

import 'package:carousel_custom_slider/src/reflection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ReflectionWidget extends StatelessWidget {
  /// The widget to be reflected.
  final Reflection widget;

  /// The index of the page.
  final int index;

  /// [onHover] callback function when the mouse is hovering over the widget.
  final void Function(PointerHoverEvent)? onHover;

  /// [onExit] callback function when the mouse is exiting the widget.
  final void Function(PointerExitEvent)? onExit;

  /// [isHovering]  true if the mouse is hovering over the widget.
  final bool isHovering;

  /// [animaton] the animation of the widget.
  final Animation<Offset> animaton;

  const ReflectionWidget({
    super.key,
    required this.widget,
    required this.index,
    required this.isHovering,
    required this.onHover,
    required this.onExit,
    required this.animaton,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            children: [
              Stack(
                children: [
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    onHover: onHover,
                    onExit: onExit,
                    child: Container(
                      width: widget.width,
                      height: widget.height,
                      decoration: BoxDecoration(
                        border: isHovering
                            ? Border.all(
                                width: 5,
                                color: widget.borderColor ??
                                    Theme.of(context).primaryColor,
                              )
                            : null,
                        image: DecorationImage(
                          fit: widget.fit,
                          image: Image.network(
                            widget.sliderList[index],
                            width: widget.width,
                            height: widget.height,
                            fit: widget.fit,
                            cacheWidth: widget.cacheWidth,
                            cacheHeight: widget.cacheHeight,
                            errorBuilder: widget.errorBuilder,
                          ).image,
                        ),
                      ),
                    ),
                  ),
                  if (isHovering)
                    widget.childrenStackBuilder!(index) ??
                        const SizedBox.shrink()
                  else
                    const SizedBox.shrink(),
                ],
              ),
            ],
          ),
          !widget.showReflection
              ? const SizedBox.shrink()
              : AnimatedOpacity(
                  duration: const Duration(milliseconds: 800),
                  opacity: isHovering ? 0 : 1,
                  child: Stack(
                    children: [
                      SlideTransition(
                        position: animaton,
                        child: Transform(
                          alignment: Alignment.center,
                          transform: Matrix4.rotationX(math.pi),
                          child: Opacity(
                            opacity: 0.4,
                            child: ShaderMask(
                              shaderCallback: (bounds) {
                                return LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    widget.shadowColorStart,
                                    widget.shadowColorEnd,
                                  ],
                                ).createShader(bounds);
                              },
                              blendMode: BlendMode.dst,
                              child: Image.network(
                                widget.sliderList[index],
                                width: widget.width,
                                height: widget.height,
                                fit: widget.fit,
                                cacheWidth: widget.cacheWidth,
                                cacheHeight: widget.cacheHeight,
                                errorBuilder: widget.errorBuilder,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}
