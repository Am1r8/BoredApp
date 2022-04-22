import 'package:bored_app/liked.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
  DeviceOrientation.portraitUp,
  ]);
  runApp(MaterialApp(
      title: 'Announdo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
      routes: {
        '/likes': (context) => const liked(),
      }
    )
  );
}