import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'dart:math' as math;
import 'package:swiping_card_deck/swiping_card_deck.dart';
import 'global.dart' as gl;

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String activity = "Swipe to see what you like";
  String type = "";
  String participants = "";
  String price = "";

  ur() async{
    var url = Uri.https("www.boredapi.com", '/api/activity/');

    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse =
          convert.jsonDecode(response.body) as Map<String, dynamic>;
      var a = jsonResponse['activity'];
      var s  = jsonResponse['type'];
      var p = jsonResponse['participants'];
      var pr = jsonResponse['price'];
      setState(() {
        activity = a;
        type = s;
        participants = p.toString();
        price = (pr*10).toString();
      });
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  liked() {
    ur();
    print(activity);
    gl.activityList.insert(0, activity);
  }

  

  @override
  Widget build(BuildContext context) {
      // ur();
      List<Card> getCardDeck() {
      List<Card> cardDeck = [];
      for (int i = 0; i < 1000; i++) {
        cardDeck.add(
        Card(
          color: Color((math.Random().nextDouble() * 0x11111).toInt()).withOpacity(1.0),
          elevation: 80,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          semanticContainer: true,
          child: SizedBox(
            height: MediaQuery.of(context).size.height - 200, 
            width: MediaQuery.of(context).size.width - 50,
            child: Center(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(activity), 
                    Text(type), 
                    Text(participants), 
                    Text(price)
                  ],
                ),
              ),
            ),
          ),
        ),
        );
      }
      return cardDeck;
    }
    final SwipingCardDeck deck = SwipingCardDeck(
      cardDeck: getCardDeck(),
      onDeckEmpty: () => debugPrint("Card deck empty"),
      onLeftSwipe: (Card card) => liked(),
      onRightSwipe: (Card card) =>  ur(),
      cardWidth: 470,
      swipeThreshold: MediaQuery.of(context).size.width / 3,
      minimumVelocity: 1000,
      rotationFactor: 0.8 / 3.14,
      swipeAnimationDuration: const Duration(milliseconds: 300),
    );
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              deck,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 70),
                  IconButton(
                    icon: const Icon(Icons.check),
                    iconSize: 30,
                    color: Colors.green,
                    onPressed: deck.animationActive ? null : () => deck.swipeRight() ,
                  ),
                  const SizedBox(width: 40),
                  IconButton(
                    icon: const Icon(Icons.clear),
                    iconSize: 30,
                    color: Colors.red,
                    onPressed: deck.animationActive ? null : () => deck.swipeLeft(),
                  ),
                ],
              ),
              // const SizedBox(height: 20),
              // TextButton(
              //   style: TextButton.styleFrom(
              //     primary: Colors.blue,
              //   ),
              //   onPressed: () {
              //     print(gl.activityList); 
              //     Navigator.of(context).pushReplacementNamed('/likes');
              //   },
              //   child: const Text('Liked'),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

