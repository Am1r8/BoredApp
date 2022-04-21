import 'package:flutter/material.dart';
import 'package:swiping_card_deck/swiping_card_deck.dart';
import 'dart:math' as math;

class ExamplePage extends StatelessWidget {
  const ExamplePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
      List<Card> getCardDeck() {
      List<Card> cardDeck = [];
      for (int i = 0; i < 500; ++i) {
        cardDeck.add(
        Card(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Text("YOUR TEXT"),
          ),
        ),
        );
      }
      return cardDeck;
    }
    final SwipingCardDeck deck = SwipingCardDeck(
      cardDeck: getCardDeck(),
      onDeckEmpty: () => debugPrint("Card deck empty"),
      onLeftSwipe: (Card card) => debugPrint("Swiped left!"),
      onRightSwipe: (Card card) => debugPrint("Swiped right!"),
      cardWidth: 700,
      swipeThreshold: MediaQuery.of(context).size.width / 3,
      minimumVelocity: 1000,
      rotationFactor: 0.8 / 3.14,
      swipeAnimationDuration: const Duration(milliseconds: 700),
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
                  IconButton(
                    icon: const Icon(Icons.clear),
                    iconSize: 30,
                    color: Colors.red,
                    onPressed: deck.animationActive ? null : () => deck.swipeLeft(),
                  ),
                  const SizedBox(width: 40),
                  IconButton(
                    icon: const Icon(Icons.check),
                    iconSize: 30,
                    color: Colors.green,
                    onPressed: deck.animationActive ? null : () => deck.swipeRight(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}