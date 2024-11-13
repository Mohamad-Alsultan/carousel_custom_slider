import 'package:carousel_custom_slider/carousel_custom_slider.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('adds one to input values', () {
    const carousel = CarouselCustomSlider(
      sliderList: [],
    );
    expect(carousel.autoPlay, true);
    expect(carousel.doubleTapZoom, true);
    expect(carousel.initialPage, 1);
  });
}
