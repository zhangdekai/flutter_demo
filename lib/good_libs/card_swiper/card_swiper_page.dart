import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

class CardSwiperPage extends StatefulWidget {
  const CardSwiperPage({super.key});

  @override
  State<CardSwiperPage> createState() => _CardSwiperPageState();
}

class _CardSwiperPageState extends State<CardSwiperPage> {
  List<String> _images = [
    'https://staticai.linke.ai/comic/post/cover/2081/12b345838667a420fa6d234f3e624af1.jpg',
    'https://resource-comic.comicai.ai/public/upload/app/test/post/cover/1995/209b72c42bc262683ceb3aadb9469f26.jpg',
    'https://staticai.linke.ai/comic/post/cover/1995/17a7a70bd02d8571f2be49f1f39b0f29.jpg',
  ];

  SwiperController controller = SwiperController();

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height * 0.6;
    return Scaffold(
      appBar: AppBar(
        title: Text('Card Swiper'),
      ),
      body: Swiper(
        itemCount: _images.length,
        itemBuilder: (con, index) {
          return Image.network(
            _images[index],
            fit: BoxFit.fill,
            height: _height,
          );
        },
        controller: controller,
        // 不循环
        loop: false,
        onIndexChanged: (index) {
          print('index === ${index}');
        },
        pagination: SwiperPagination(margin: EdgeInsets.only(bottom: 60)),
      ),
    );
  }
}
