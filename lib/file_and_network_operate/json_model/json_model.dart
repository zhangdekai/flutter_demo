import 'package:json_annotation/json_annotation.dart';
part 'json_model.g.dart';

/*
https://book.flutterchina.club/chapter11/json_model.html#_11-7-1-json转dart类
lib: json_serializable

更加方便的是可以使用 Json_model lib, 只需维护json 文件即可

 */

@JsonSerializable()
class  MateModel {
  var name;
  var age;
  MateModel(this.name,this.age);
  factory MateModel.fromJson(Map<String,dynamic> json) => _$MateModelFromJson(json);
  Map<String,dynamic> toJson() => _$MateModelToJson(this);
}