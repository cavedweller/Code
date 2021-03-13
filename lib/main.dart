import 'package:flutter/material.dart';
import 'TestFile.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(CrudFirestore());
}

class CrudFirestore extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Tester(),
      debugShowCheckedModeBanner: false,
    );
  }
}
