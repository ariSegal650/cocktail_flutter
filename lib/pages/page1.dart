import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sushi/models/Cocktail.dart';
import 'package:sushi/services/api_service.dart';
import '../components/card.dart';
import '../components/search.dart';
import 'favoritePage.dart';

class Page1 extends StatefulWidget {
  const Page1({Key? key});

  @override
  _Page1State createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  List<Cocktail> listCoctails = [];
  List<Cocktail> listCoctailsKeeper = [];

  bool isLoading = false;
  int page = 1;
  bool onSearch = false;
  bool isSuccessful = false;
  final ScrollController _scrollController = ScrollController();

  final String searchInput = "";

  Future<void> fetchData() async {
    try {
      isLoading = true;
      final cocktails = await api_service
          .getApi()
          .getCocktails()
          .whenComplete(() => isLoading = false);
      isSuccessful = true;
      print("new list");

      setState(() {
        isSuccessful = true;
        listCoctails = cocktails;
        listCoctailsKeeper = cocktails;
      });
    } catch (e) {
      isLoading = false;
      print("'4444' + $e");

      setState(() {
        isLoading = false;
      });
    }
  }

  // function get the text from search;
  void handleTextSubmitted(String text) {
    onSearch = true;
    print(text);
    final serchList = listCoctailsKeeper
        .where((cocktail) =>
            cocktail.title.toLowerCase().contains(text.toLowerCase()))
        .toList();

    setState(() {
      listCoctails = serchList;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        print('last'); // Print "last" when the end of the list is reached
        setState(() {
          page++;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Lottie.asset(
                'assets/animation_lmqicv15.json',
                width: double.infinity,
              ),
            ]),
      );
    } else if (!isSuccessful) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(16.0), // Adjust the margin as needed
          child: Text("some error occurred ):"),
        ),
      );
    }
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.fromLTRB(3, 12, 3, 15),
          child: search(onTextSubmitted: handleTextSubmitted),
        ),
        Container(
          color: const Color.fromARGB(255, 223, 234, 243),
          height: 350,
          child: ListView.builder(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            itemCount: listCoctails.length > page * 10
                ? page * 10
                : listCoctails.length,
            itemBuilder: (context, index) {
              return CustomCard(
                id: listCoctails[index].id,
                name: listCoctails[index].title,
                image: listCoctails[index].image,
                difficulty: listCoctails[index].difficulty,
              );
            },
          ),
        ),
        
        Container(
          color: const Color.fromARGB(255, 223, 234, 243),
          child: Column(
            children: [
              !favorite().favoriteList.isEmpty
                  ? const Column(
                      children: [
                        favorite(),
                      ],
                    )
                  : const SizedBox(),
            ],
          ),
        )
      ],
    );
  }
}
