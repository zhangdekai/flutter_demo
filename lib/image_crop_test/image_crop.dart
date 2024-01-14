import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'dart:ui' as ui;

/// 图片裁剪
class ImageClipper extends CustomPainter {
  final ui.Image image;
  final double? left;
  final double? top;
  final double? right;
  final double? bottom;

  ImageClipper(this.image,
      {Key? key,
      this.left = 0.3,
      this.top = 0.3,
      this.right = 0.6,
      this.bottom = 0.6});

  late ui.PictureRecorder recorder;
  Size _size = Size.zero;

  @override
  void paint(Canvas canvas, Size size) {
    _size = Size(size.width, size.height);

    recorder = ui.PictureRecorder();

    // Canvas canvas1 = Canvas(recorder);

    Paint paint = Paint();

    canvas.drawImageRect(
        image,
        Rect.fromLTRB(image.width * left!, image.height * top!,
            image.width * right!, image.height * bottom!),
        Rect.fromLTWH(0, 0, size.width, size.height),
        paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }

  void reloadImage() {
    recorder = ui.PictureRecorder();
    final ui.Canvas canvas = Canvas(recorder);

    Paint paint = Paint();

    canvas.drawImageRect(
        image,
        Rect.fromLTRB(image.width * left!, image.height * top!,
            image.width * right!, image.height * bottom!),
        Rect.fromLTWH(0, 0, _size.width, _size.height),
        paint);
  }

  Future<MemoryImage> toImage() async {
    Completer<MemoryImage> completer = Completer<MemoryImage>();

    Picture picture = recorder.endRecording();

    picture.toImage(200, 200).then((value) => value.toByteData().then((value) {
          if (value != null) {
            Uint8List temp = value.buffer.asUint8List();
            completer.complete(MemoryImage(temp));
          }
        }));

    return completer.future;
  }
}

const String pic =
    'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fpic1.win4000.com%2Fwallpaper%2F9%2F53605fc6be05e.jpg&refer=http%3A%2F%2Fpic1.win4000.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1626594754&t=708f16dbc19acf887e51844c5a6ddbd1';

class ImageClipperTest extends StatefulWidget {
  @override
  State createState() {
    // TODO: implement createState
    return _ImageClipperTestState();
  }
}

class _ImageClipperTestState extends State {

  late ImageClipper clipper;

  late MemoryImage? _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ImageClipper'),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              child: Container(
                  color: Colors.grey,
                  child: Image.network(
                    pic,
                    fit: BoxFit.fill,
                  )),
              width: 200,
              height: 150,
            ),
            SizedBox(
              height: 50,
            ),
            Container(
                color: Colors.green,
                child: CustomPaint(
                  painter: clipper,
                  size: Size(100, 100),
                )),
            TextButton(child: Text('Clip'), onPressed: () => clip()),
            _image != null
                ? Container(
                    width: 200,
                    height: 200,
                    child: Image(image: _image!),
                  )
                : Container(
                    width: 100,
                    height: 50,
                    color: Colors.yellow,
                  ),
          ],
        ),
      ),
    );
  }

  Future _loadImge() async {
    ImageStream imageStream = NetworkImage(pic).resolve(ImageConfiguration());
    Completer completer = Completer();
    void imageListener(ImageInfo info, bool synchronousCall) {
      ui.Image image = info.image;
      completer.complete(image);
      imageStream.removeListener(ImageStreamListener(imageListener));
    }

    imageStream.addListener(ImageStreamListener(imageListener));
    return completer.future;
  }

  void clip() async {
    late ui.Image uiImage;
    _loadImge().then((image) {
      uiImage = image;
    }).whenComplete(() {
      clipper = ImageClipper(uiImage);
      setState(() {});

      // Future.delayed(Duration(seconds: 1),(){
      //
      //   clipper.reloadImage();
      //
      //   clipper.toImage().then((value) {
      //     _image = value;
      //
      //     setState(() {});
      //   });
      // });
    });
  }
}
