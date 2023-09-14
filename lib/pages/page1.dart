import 'package:flutter/material.dart';
import 'package:sushi/models/Cocktail.dart';
import 'package:sushi/models/Cocktail_parametrs.dart';
import 'package:sushi/services/api_service.dart';
import '../components/card.dart';
import '../components/search.dart';
import '../services/localStore.dart';

class Page1 extends StatefulWidget {
  const Page1({Key? key});

  @override
  _Page1State createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  List<Cocktail> listCoctails = [];
  List<Cocktail_parametrs> faivortList = [];
  bool isLoading = false;
  int page = 1;
  int pageF = 1;

  bool isSuccessful = false;
  final ScrollController _scrollController = ScrollController();
  final ScrollController _scrollControllerF = ScrollController();

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
      });
    } catch (e) {
      isLoading = false;
      print("'4444' + $e");

      setState(() {
        isLoading = false;
      });
    }
    getAllFaviort();
  }

  Future<void> getAllFaviort() async {
   // LocalStore().clearAllData();
    try {
      final faivort=await LocalStore().getAllStrings();
      setState(() {
        faivortList=faivort;
      });
        print(faivortList);
        print("poipoi pp");
    } catch (e) {
      print("object");
    }
  }

  // function get the text from search;
  void handleTextSubmitted(String text) {
    setState(() {
      print(text);
    });
  }
   Future<bool> onWillPop() async {
   print("uuu");
   return true;
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

    _scrollControllerF.addListener(() {
      if (_scrollControllerF.position.pixels ==
          _scrollControllerF.position.maxScrollExtent) {
        print('last'); // Print "last" when the end of the list is reached
        setState(() {
          pageF++;
        });
      }
    });
   
  }
    

  @override
  Widget build(BuildContext context) {

    if (isLoading) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(16.0), // Adjust the margin as needed
          child: CircularProgressIndicator(),
        ),
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
          margin: const EdgeInsets.fromLTRB(
              3, 12, 3, 15), // Add margin around TextField
          child: search(onTextSubmitted: handleTextSubmitted),
        ),
        Container(
          color: const Color.fromARGB(255, 223, 234, 243),
          height: 350,
          child: ListView.builder(
            controller: _scrollController, // Assign the ScrollController
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
          height: 350,
          child: ListView.builder(
            controller: _scrollControllerF, // Assign the ScrollController
            scrollDirection: Axis.horizontal,
            itemCount: faivortList.length > pageF * 10
                ? pageF * 10
                : faivortList.length,

            itemBuilder: (context, index) {
              return CustomCard(
                id: faivortList[index].id,
                name: listCoctails[index].title,
                image: faivortList[index].image,
                difficulty: faivortList[index].difficulty,
              );
            },
          ),
        ),
      ],
    );
  }
}
