/*
比较2个对象是否相等, bool identical(Object? a, Object? b)

对于两个同类型的对象，它们的 hashCode 值不一定相同。
只有当两个对象的 实际值相同并且它们的 引用地址相同，它们的 hashCode 值才会相同

 final  const 区别


 */

const Function getGreeting = _tempFun;

const String _string = '';

void _tempFun(int a) {
  print('a == $a');
}

class Person1 {
  const Person1();
}

class Person {
  String name;
  int age;

  Person1? agge;

  Person(this.name, this.age, {Person1 agge = const Person1()});

  void test() {
    getGreeting.call(10);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    if (other is Person) {
      return name == other.name && age == other.age;
    }

    return false;
  }
}

void _testPerson(){
  Person a = Person("John", 30);

  Person b = Person("John", 30);

  Person c = a;

  print(a == b); // true
  print(a == c); // true

  print('a === $a');
  print('a.runtimeType === ${a.runtimeType}  a.hashCode == ${a.hashCode}');

  print('b === $b');
  print('b.runtimeType === ${b.runtimeType}  b.hashCode == ${b.hashCode}');

  print('c === $c');
  print('c.runtimeType === ${c.runtimeType}  c.hashCode == ${c.hashCode}');
}

void main() {

  _testPerson();

  _testFinalDynamic(); // 不会报错

  _testListFunc();

}

void _testListFunc() {
  List<int> bb = [1, 3, 0, 2];
  final res = bb.map((e) => e > 2).toList();

  print('res == $res');

  print(bb.expand(count));

  // 扩展List
  print(bb.expand((element) => [element * 2]).toList());// [2, 6, 0, 4]

  /// 缩减集合元素到一个值
  final cc = bb.reduce((value, element) => value+ element);
  print('bb.reduce cc = $cc');// bb.reduce cc = 6
}

Iterable<int> count(int n) sync* {
    for (var i = 1; i <= n; i++) {
       yield i;
      }
}

void _testFinalDynamic() {
  final ee = 15;
  // ee = 16;  不可再修改了，只能set once
  print('ee == $ee');

  final p = Person("John", 30);
  p.name = '22';
  print('p.name  == ${p.name}');

  dynamic value;
  value = "John";
  value = 123; // 不会报错
}
