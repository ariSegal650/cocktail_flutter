import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/Cocktail_parametrs.dart';

class LocalStore {
  
static List<Cocktail_parametrs> _cocktailList = [];

  void saveCocktail(String key, Cocktail_parametrs value) async {
    final prefs = await SharedPreferences.getInstance();
    final cocktailJson = jsonEncode(value.toJson());
    await prefs.setString(key, cocktailJson);
    _cocktailList=await getAllStrings();
  }

  void removeData(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
    _cocktailList=await getAllStrings();
  }

  Future<Cocktail_parametrs?> getCocktail(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final cocktailJson = prefs.getString(key);
    if (cocktailJson == null) {
      return null;
    }
    final Map<String, dynamic> cocktailMap = jsonDecode(cocktailJson);
    return Cocktail_parametrs.fromJson(cocktailMap);
  }
  Future<bool> checkExist(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final cocktailJson = prefs.getString(key);
    if (cocktailJson == null) {
      return false;
    }
    return true;
  }

  Future<List<Cocktail_parametrs>> getAllStrings() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final allKeys = prefs?.getKeys();
     final List<Cocktail_parametrs> result =[];
      if (allKeys != null) {
        for (final key in allKeys) {
          final value = prefs.getString(key);
          if (value != null) {
            final Map<String, dynamic> cocktailMap = jsonDecode(value);
            final temp = Cocktail_parametrs.fromJson(cocktailMap);
            result.add(temp);
          }
        }
      }
      _cocktailList =result;
      return result;
    } catch (e) {
      print("555");
    }
     _cocktailList =List.empty();
    return List.empty();
  }

  void clearAllData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    _cocktailList=await getAllStrings();

  }
}
