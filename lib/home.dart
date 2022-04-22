import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
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
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {}
    } on SocketException catch (_) {
        Fluttertoast.showToast(
        msg: "There is no internet connection",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
    }

    var url = Uri.https("www.boredapi.com", '/api/activity/');
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
      Fluttertoast.showToast(
        msg: "There is no activity",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
    }
  }

  liked() {
    ur();
    gl.activityList.insert(0, activity);
  }



  @override
  Widget build(BuildContext context) {
      if (price == "0") {
        price = "Free";
      }
      List<Card> getCardDeck() {
      List<Card> cardDeck = [];
      for (int i = 0; i < 1000; i++) {
        cardDeck.add(
        Card(
          color: Color((0xFF715B).toInt()).withOpacity(1.0),
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
                constraints: const BoxConstraints(minWidth: 150, maxWidth: 250),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Activity:\n"+activity, style: TextStyle(fontFamily: 'Nanum', fontSize: 30.0, color: Colors.white), textAlign: TextAlign.center),
                    const SizedBox(height: 50),
                    Text("Category:\n"+type, style: const TextStyle(fontFamily: 'Nanum', fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.w500), textAlign: TextAlign.center),
                    const SizedBox(height: 50),
                    Text("Required People: "+participants, style: TextStyle(fontFamily: 'Nanum', fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.w500), textAlign: TextAlign.center),
                    const SizedBox(height: 20),
                    Text("Price: \$" + price, style: TextStyle(fontFamily: 'Nanum', fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.w500), textAlign: TextAlign.center)
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
                    iconSize: 50,
                    color: Color((0x1EA896).toInt()).withOpacity(1.0),
                    onPressed: deck.animationActive ? null : () => deck.swipeRight() ,
                  ),
                  const SizedBox(width: 40),
                  IconButton(
                    icon: const Icon(Icons.clear),
                    iconSize: 50,
                    color: Color((0x523F38).toInt()).withOpacity(1.0),
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

