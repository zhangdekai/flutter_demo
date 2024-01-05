import 'dart:async';

class StreamTestModel {
  String content;
  StreamTestModel(this.content);
}



final streamController = StreamController<StreamTestModel>();


void main() {

  final streamSubscription = streamController.stream.listen((event) {
    print('event.content = ${event.content}');
  });

  streamController.add(StreamTestModel('你好22'));
  streamController.add(StreamTestModel('你好33'));


  streamController.sink.add(StreamTestModel('你好44'));



  // streamController.close();
  //
  // streamSubscription.cancel();
}

void testStream(){


}
