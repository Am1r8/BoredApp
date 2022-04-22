import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'global.dart' as gl;
class liked extends StatefulWidget {
  const liked({ Key? key }) : super(key: key);

  @override
  State<liked> createState() => _likedState();
}

class _likedState extends State<liked> {
  
  List<String> activity = gl.activityList;
  @override
  Widget build(BuildContext context) {
    activity.removeLast();
    const title = 'Mixed List';

    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(title),
        ),
        body: ListView.builder(
          itemCount: activity.length,
          itemBuilder: (context, index) {
            final item = activity[index];

            return ListTile(
              title: Text(item),
              trailing: IconButton(onPressed: () {
                setState(() {
                  activity.removeAt(index);
                });
                print(activity);
                }, icon: Icon(Icons.favorite)),
            );
          },
        ),
      ),
    );
  }
}