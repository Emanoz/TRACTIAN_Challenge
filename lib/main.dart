import 'package:flutter/material.dart';
import 'package:tractian_app/ui/menu/menu_page.dart';
import 'package:tractian_app/utils/remove_glowing_behavior.dart';

const String baseUrl = 'https://my-json-server.typicode.com/tractian/fake-api';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) {
        return ScrollConfiguration(
          behavior: RemoveGlowingBehavior(),
          child: child!,
        );
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: const Color(0x0017192D),
          appBarTheme: const AppBarTheme(
            color: Color(0xFF17192D),
          ),
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: Color(0xFF17192D),
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white38,
          )),
      home: const MenuPage(),
    );
  }
}
