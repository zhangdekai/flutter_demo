import 'package:json_annotation/json_annotation.dart';
part 'json_model.g.dart';

@JsonSerializable()
class  MateModel {
  var name;
  var age;
  MateModel(this.name,this.age);
  factory MateModel.fromJson(Map<String,dynamic> json) => _$MateModelFromJson(json);
  Map<String,dynamic> toJson() => _$MateModelToJson(this);
}