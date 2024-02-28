import 'package:flutter/material.dart';

/// @immutable
/*
Flutter 注解是用于在 Flutter 代码中添加元数据的一种特殊语法。元数据是附加信息，
可以用于指导编译器、静态分析器和其他工具执行特定操作。

Flutter 注解以 @ 符号开头，后跟一个编译时常量表达式。例如：

@immutable
class MyClass {
  // ...
}
在这个示例中，我们使用 @immutable 注解来表明 MyClass 是不可变的。这意味着 MyClass 实例的状态不能在创建后更改。

Flutter 中的内置注解包括：

@immutable: 表示类或对象是不可变的。
@required: 表示构造函数参数或字段是必需的。
@deprecated: 表示类、方法或字段已过时。
@override: 表示方法覆盖了其父类中的方法。
@protected: 表示成员只能在类及其子类中访问。
@public: 表示成员可以在任何地方访问。
除了内置注解之外，您还可以创建自定义注解。自定义注解可以用于提供有关代码的更多信息，例如：

@route('/home')
class HomePage extends StatelessWidget {
  // ...
}
在这个示例中，我们使用自定义注解 @route 来指定 HomePage 路由。

Flutter 注解的优势包括：

提高代码可读性: 注解可以使代码更易于理解，因为它可以提供有关代码意图的额外信息。
提高代码质量: 注解可以帮助您避免错误，例如使用过时的方法或忘记指定必需的参数。
提高开发效率: 注解可以自动化一些任务，例如生成代码或执行静态分析。


====================================================================================

Flutter 注解的应用
Flutter 注解可以用于各种目的，包括：

状态管理: Flutter 中的内置注解 @immutable 可用于表示类或对象是不可变的。这可以帮助您避免意外更改状态，并使代码更易于推理。
路由: Flutter 中的自定义注解 @route 可用于指定路由。这可以使您更轻松地定义应用程序的导航。
依赖注入: Flutter 中的第三方库 provider 使用注解来注入依赖项。这可以使您的代码更易于测试和维护。
代码生成: Flutter 中的第三方库 build_runner 可用于使用注解生成代码。这可以使您自动化一些任务，例如生成测试代码或国际化字符串。

 */

/*
状态管理:
在这个示例中，我们使用 @immutable 注解来表明 User 类是不可变的。
这意味着 User 实例的状态不能在创建后更改。
 */
@immutable
class User {
  final String name;
  final int age;

  const User(this.name, this.age);
}

/// @protected
class FHomePage {
  @protected
  void initConfig(){

  }
}

/// jsonModel @JsonSerializable()  帮助生成 相应的model