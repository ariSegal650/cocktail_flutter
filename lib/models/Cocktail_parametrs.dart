import 'package:json_annotation/json_annotation.dart';

part 'Cocktail_parametrs.g.dart';

@JsonSerializable()
class Cocktail_parametrs {
  final String id;
  final String title;
  final String difficulty;
  final String portion;
  final String time;
  final String description;
  final List<String> ingredients;
 final List<dynamic> method;
   final String image;

  Cocktail_parametrs({
    required this.id,
    required this.title,
    required this.difficulty,
    required this.portion,
    required this.time,
    required this.description,
    required this.ingredients,
    required this.method,
    required this.image,
  });

  
  factory Cocktail_parametrs.fromJson(Map<String, dynamic> json) => _$Cocktail_parametrsFromJson(json);
  
  Map<String, dynamic> toJson() => _$Cocktail_parametrsToJson(this);
}
