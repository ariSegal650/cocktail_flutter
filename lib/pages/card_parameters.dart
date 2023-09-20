import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sushi/models/Cocktail_parametrs.dart';
import 'package:sushi/services/api_service.dart';

import '../components/ListTile.dart';
import '../services/localStore.dart';

class CardParameters extends StatefulWidget {
  const CardParameters({
    super.key,
  });

  @override
  State<CardParameters> createState() => _CardParameterstState();
}

class _CardParameterstState extends State<CardParameters> {
  late Cocktail_parametrs item;
  List<Cocktail_parametrs> faivortList = List.empty();
int? maxLines = 1;

  bool isLoading = true;
  bool one = false;
  bool FaivorteIcon = false;

  Future<void> fetchData(String id) async {
    if (!one) {
      try {
        item = await api_service.getApi().getCocktailparameters(id);
        FaivorteIcon = await LocalStore().checkExist(item.id);
        one = true;
        setState(() {
          isLoading = false;
        });
      } catch (e) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final String id = ModalRoute.of(context)?.settings.arguments as String;
    fetchData(id);
    if (isLoading) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(16.0), // Adjust the margin as needed
          child: CircularProgressIndicator(),
        ),
      );
    }
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Image.network(item.image,
                    width: double.infinity, fit: BoxFit.cover),
                Positioned(
                  top: 50,
                  right: 25,
                  child: SizedBox(
                    width: 80,
                    height: 25,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Container(
                        color:
                            Colors.white, // Set the background color to white
                        child: Center(
                          child: Text(
                            item.difficulty,
                            style: TextStyle(
                              fontSize: 16,
                              color: item.difficulty == 'Easy'
                                  ? Colors.green
                                  : (item.difficulty == 'Hard'
                                      ? Colors.red
                                      : Colors.black),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 50,
                  left: 16,
                  child: SizedBox(
                    width: 54,
                    height: 28,
                    child: ElevatedButton(
                      onPressed: () async {
                        //   LocalStore().clearAllData();
                        if (!FaivorteIcon) {
                          LocalStore().saveCocktail(item.id, item);
                          print("saved");
                        } else {
                          LocalStore().removeData(item.id);
                        }
                        //  LocalStore().streamController.add(111);
                        setState(() {
                          FaivorteIcon = !FaivorteIcon;
                        });
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.black26),
                      ),
                      child: Icon(
                        Icons.favorite_rounded,
                        size: 30,
                        color: FaivorteIcon ? Colors.red : Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color.fromARGB(
                    255, 111, 106, 106), // Example background color
              ),
              child: Center(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 5, 0, 10),
                      child: Text(
                        item.title,
                        style: const TextStyle(
                          color: Color.fromARGB(255, 239, 181, 181),
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(6, 0, 2, 5),
                      child: Text(
                        item.description,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: const Text(
                            'Ingredients:',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 149, 253, 194),
                            ),
                          ),
                        ),
                        Container(
                          //height: 400, // Set the desired height
                          margin: const EdgeInsets.fromLTRB(15, 8, 0, 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:
                                List.generate(item.ingredients.length, (index) {
                              final ingredient = item.ingredients[index];
                              final indexPlus = index + 1;
                              return Row(
                                children: [
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          maxLines =2;
                                        });
                                        print("tap");
                                      },
                                      child: Text(
                                        '$indexPlus. $ingredient',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal,
                                          color: Color.fromARGB(
                                              255, 151, 226, 183),
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: maxLines,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              child: Column(
                children: List.generate(item.method.length, (index) {
                  final step = item.method[index];
                  return ListTileApp(step: step, IndexP: index);
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
