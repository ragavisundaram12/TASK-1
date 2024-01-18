import 'package:flutter/material.dart';
import 'package:todo/NewScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('TODO APP'),
          centerTitle: true,
          backgroundColor: Colors.pinkAccent,
        ),
        body: Align(
          alignment: Alignment.bottomRight,
          child: Builder(
            builder: (context) => IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const NewScreen();
                    },
                  ),
                );
              },
              icon: Image.asset("assets/todo image.png"),
              iconSize: 70,
            ),
          ),
        ),
      ),
    );
  }
}
