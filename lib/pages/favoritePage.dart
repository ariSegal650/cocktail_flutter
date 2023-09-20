import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../components/card.dart';
import '../models/Cocktail_parametrs.dart';
import '../services/localStore.dart';

class favorite extends StatefulWidget {
  final String? page;
  const favorite({super.key, required this.page});

  @override
  State<favorite> createState() => _favoriteState();
  List<Cocktail_parametrs> get favoriteList => _favoriteState.faivortList;
}

class _favoriteState extends State<favorite> {
  static List<Cocktail_parametrs> faivortList = [];
  bool isLoading = true;
  int page = 1;
  final ScrollController _scrollController = ScrollController();

  Future<void> getAllFaviort() async {
    try {
      WidgetsFlutterBinding.ensureInitialized();

      final faivort = await LocalStore().getAllStrings();

      setState(() {
        faivortList = faivort;
      });
      isLoading = false;
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
   // getAllFaviort();
   

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
    getAllFaviort();
    if (isLoading && widget.page!="page1") {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: CircularProgressIndicator(),
        ),
      );
    }
     else if (faivortList.isEmpty && widget.page!="page1") {
      return Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(
                  'assets/animation_lmovdkza.json',
                  width: 150,
                  height: 150,
                ),
                const Text(
                  "There are no items in your favorite list",
                ),
              ],
            ),
          ),
        ),
      );
    }
    return Container(
      color: const Color.fromARGB(255, 223, 234, 243),
      child: Column(
        children: [
          Container(
            height: 50,
            color: const Color.fromARGB(255, 223, 234, 243),
          ),
          if(!faivortList.isEmpty)
          const Text(
            "Favorite:",
            style: TextStyle(fontSize: 20),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20),
            height: 350,
            child: ListView.builder(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: faivortList.length > page * 10
                  ? page * 10
                  : faivortList.length,
              itemBuilder: (context, index) {
                return CustomCard(
                  id: faivortList[index].id,
                  name: faivortList[index].title,
                  image: faivortList[index].image,
                  difficulty: faivortList[index].difficulty,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
