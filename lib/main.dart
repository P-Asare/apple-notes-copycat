import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:notes_proj/modules/notedata.dart';
import 'package:notes_proj/pages/homepage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  // init box
  await Hive.initFlutter();

  // open box
  await Hive.openBox('notes_database');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NoteData(),
      builder: (context, child) => const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );
  }
}
