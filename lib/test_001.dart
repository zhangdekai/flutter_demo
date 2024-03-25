import 'dart:math';

class Point {
  int x;
  int y;
  Point(this.x, this.y);
}

double kValue(Point a, Point b) {
  int y = (a.x - b.x);

  if(y == 0){

  }

  return (a.y - b.y) / (a.x - b.x);
}



void main() {
  List<Point> pointList1 = List.generate(
      3, (index) => Point(Random().nextInt(3), Random().nextInt(3)));
  // print('pointList = $pointList');

  List<Point> pointList = [Point(0, 0), Point(1, 1), Point(2, 2)];

  Point point1 = pointList.first;
  Point point2 = pointList[1];
  Point point3 = pointList[2];

  double k1 = kValue(point1, point2);

  double k2 = kValue(point2, point3);

  if (k1 == k2) {
    print('在一条直线上 k == $k1'); // -Infinity
  } else {
    print('no 在一条直线上');
  }

  // for (int i = 0; i < pointList.length; i++){
  //
  //
  // }
}
