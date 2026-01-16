import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:bigio_test_app/features/character/presentation/pages/home_page.dart';
import 'package:bigio_test_app/features/character/presentation/provider/character_provider.dart';
import 'package:bigio_test_app/injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => di.sl<CharacterProvider>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Rick & Morty App',
        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: Colors.green, 
        ),
        home: HomePage()
      ),
    );
  }
}
