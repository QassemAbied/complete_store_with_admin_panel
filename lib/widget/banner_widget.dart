import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

class BannerWidget extends StatelessWidget {
  BannerWidget({super.key});

  List<String> imageBanner = [
    'assets/images/26.png',
    'assets/images/20.png',
    'assets/images/23.png',
    'assets/images/15.png',
    'assets/images/14.png',
    'assets/images/13.png',
    'assets/images/2.png',
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 250,
      color: Colors.deepPurple.shade50,
      child: Swiper(
        autoplay: true,
        allowImplicitScrolling: true,
        itemBuilder: (BuildContext context, int index) {
          return Image(image: AssetImage(imageBanner[index]));
        },
        itemCount: imageBanner.length,
        pagination: SwiperPagination(
            builder: DotSwiperPaginationBuilder(
                color: Colors.deepPurple.shade200,
                activeColor: Colors.deepPurple)),
          control: SwiperControl(),
      ),
    );
  }
}
