// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Cocktail_parametrs.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Cocktail_parametrs _$Cocktail_parametrsFromJson(Map<String, dynamic> json) =>
    Cocktail_parametrs(
      id: json['id'] as String,
      title: json['title'] as String,
      difficulty: json['difficulty'] as String,
      portion: json['portion'] as String,
      time: json['time'] as String,
      description: json['description'] as String,
      ingredients: (json['ingredients'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      method: json['method'] as List<dynamic>,
      image: json['image'] as String,
    );

Map<String, dynamic> _$Cocktail_parametrsToJson(Cocktail_parametrs instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'difficulty': instance.difficulty,
      'portion': instance.portion,
      'time': instance.time,
      'description': instance.description,
      'ingredients': instance.ingredients,
      'method': instance.method,
      'image': instance.image,
    };
