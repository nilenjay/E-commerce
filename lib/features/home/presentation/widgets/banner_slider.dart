import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';

class BannerSlider extends StatelessWidget{

  final List<String> banners;

  const BannerSlider({required this.banners});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
        options: CarouselOptions(
          height: 160,
          autoPlay: true,
          enlargeCenterPage: true,
          viewportFraction: 0.9,
        ),
        items: banners.map((imageUrl){
          return ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          );
        }).toList(),
    );
  }
}