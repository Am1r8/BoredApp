import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class liked extends StatefulWidget {
  const liked({ Key? key }) : super(key: key);

  @override
  State<liked> createState() => _likedState();
}

class _likedState extends State<liked> {
  List<String> activity = ["kjhakjsdh", ":jgjhjasd"];
  @override
  Widget build(BuildContext context) {
    const title = 'Mixed List';

    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(title),
        ),
        body: ListView.builder(
          // Let the ListView know how many items it needs to build.
          itemCount: activity.length,
          // Provide a builder function. This is where the magic happens.
          // Convert each item into a widget based on the type of item it is.
          itemBuilder: (context, index) {
            final item = activity[index];

            return ListTile(
              title: Text(item),
              trailing: IconButton(onPressed: () {}, icon: Icon(Icons.favorite)),
            );
          },
        ),
      ),
    );
  }
}