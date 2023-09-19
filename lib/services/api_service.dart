import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:sushi/models/Cocktail.dart';
import 'package:sushi/models/Cocktail_parametrs.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: "https://the-cocktail-db3.p.rapidapi.com/") // Replace with your API base URL
abstract class api_service {
  factory api_service(Dio dio,{String baseUrl}) = _api_service;
 
  static api_service getApi()=> api_service(Dio());

  @GET("")
  @Headers(<String, dynamic>{
		"X-RapidAPI-Key": "70476f7d4fmsh05e13af489e2519p15868bjsnaf900dbec2ec" ,
		"X-RapidAPI-Host": "the-cocktail-db3.p.rapidapi.com",
	})
  Future<List<Cocktail>> getCocktails();

  @GET("{id}")
  @Headers(<String, dynamic>{
		"X-RapidAPI-Key": "70476f7d4fmsh05e13af489e2519p15868bjsnaf900dbec2ec" ,
		"X-RapidAPI-Host": "the-cocktail-db3.p.rapidapi.com",
	})
  Future<Cocktail_parametrs> getCocktailparameters(@Path("id") String id);
}


