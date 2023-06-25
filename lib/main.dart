import 'package:flutter/material.dart';

import 'HomeScreen.dart';


main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo',
      home: HomeScreen(),
    );
  }
}
