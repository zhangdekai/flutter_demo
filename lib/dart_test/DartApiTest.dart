
/// 模式  Dart 3.0 新特性
/// https://juejin.cn/post/7240838046789648442
/// 解构能力
void recordAndPatternTest() {
  var user = ('xiao ming', 2);
  String name = user.$1;
  int counter = user.$2;
  print('name == $name, count == $counter');

  var (nick, age) = user; // 直接解构对象
  print('======$nick====${age}===');

  var position = (x: 1, y: 3, 'p0');
  var (x: a, y: b, c) = position;
  print('====$a====$b====$c====');
}

enum Vehicle implements Comparable<Vehicle> {
  car(tires: 4, passengers: 5, carbonPerKilometer: 400),
  bus(tires: 6, passengers: 50, carbonPerKilometer: 800),
  bicycle(tires: 2, passengers: 1, carbonPerKilometer: 0);

  const Vehicle({
    required this.tires,
    required this.passengers,
    required this.carbonPerKilometer,
  });

  final int tires;
  final int passengers;
  final int carbonPerKilometer;

  int get carbonFootprint => (carbonPerKilometer / passengers).round();

  bool get isTwoWheeled => this == Vehicle.bicycle;

  int get sum => this.tires + this.carbonFootprint + this.carbonPerKilometer;

  @override
  int compareTo(Vehicle other) => carbonFootprint - other.carbonFootprint;
}

void useEnumTest() {
  Vehicle carVehicle = Vehicle.car;
  print('vehicle.car.ti == ${carVehicle.tires}');
  print('vehicle. sum == ${carVehicle.sum}');
}

class BuildTestCase {
  final List<int> _list = [];

  void _registerAA() {
    print('_registerAA');
  }
}

void visitClassPrivate() {
  BuildTestCase case1 = BuildTestCase();

  case1._registerAA();

  print('${case1._list}');
}

void forTest(){
  for (int i = 0; i < 5; i += 1) {
    print('i === $i');
  }
}

void keyModifierTest(){
  Object a = 'qq';
  a  = 2;
  a  = [1,2,3];
  print('a ==  $a');

  a = Future(() => print('a became Future'));

  print('a ==  ${a.toString()}');
  print('a ==  ${a.runtimeType}');


  dynamic b = '22';
  b = 12;
  b = '33';
  print('b ==  $b');
  print('b.runtimeType ==  ${b.runtimeType}');

  // b = Future(() => print('b became Future'));


}

void main() {
  // recordAndPatternTest();
  // useEnumTest();
  // visitClassPrivate();
  keyModifierTest();

}

// 定义一个接口
abstract class Shape {
  int count = 0;
  double getArea(); // 抽象方法，具体类需要实现

  String getName();
}

// 实现接口的具体类, implements 必须实现所有的 方法和 属性。
class Circle implements Shape {
  double radius;

  Circle(this.radius);

  @override
  double getArea() {
    return 3.14 * radius * radius;
  }

  @override
  int count = 3;

  @override
  String getName() {
    throw UnimplementedError();
  }
}

class Rectangle implements Shape {
  double width;
  double height;

  Rectangle(this.width, this.height);

  @override
  double getArea() {
    return width * height;
  }

  @override
  int count = 2;

  @override
  String getName() {
    // TODO: implement getName
    throw UnimplementedError();
  }
}

void testObject() {
  // 创建 Circle 对象并调用 getArea 方法
  Circle circle = Circle(5.0);
  print('Circle Area: ${circle.getArea()}');

  // 创建 Rectangle 对象并调用 getArea 方法
  Rectangle rectangle = Rectangle(4.0, 6.0);
  print('Rectangle Area: ${rectangle.getArea()}');
}

