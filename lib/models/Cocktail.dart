import 'package:json_annotation/json_annotation.dart';

part 'Cocktail.g.dart';

@JsonSerializable()
class Cocktail {
  String id;
  String title;
  String difficulty;
  String image;

  Cocktail({
    required this.id,
    required this.title,
    required this.difficulty,
    required this.image,
  });

 factory Cocktail.fromJson(Map<String, dynamic> json) => _$CocktailFromJson(json);
  Map<String, dynamic> toJson() => _$CocktailToJson(this);
}