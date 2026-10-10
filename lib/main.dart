import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notes_app/Pages/note_page.dart';
import 'package:notes_app/Theme/app_theme.dart';
import 'package:provider/provider.dart';

import 'Logic/note_provider.dart';
import 'Pages/home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('notesBox');

  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (n) => NoteProvider())],

      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      routes: {
        '/notepage': (context) => NotePage(),
        '/homepage': (context) => HomePage(),
      },
      home: HomePage(),
    );
  }
}
