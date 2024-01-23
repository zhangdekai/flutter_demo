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

void main() {
  // recordAndPatternTest();
  useEnumTest();
}
