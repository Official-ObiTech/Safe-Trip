import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:safe_trip/screens/(auth)/register.dart';
import 'package:safe_trip/widget/(firebase)/options.dart';

void main() async {
 

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Safe Trip',
      debugShowCheckedModeBanner: false,
      
      theme: CustomTheme.theme(),
      home: Register(),
    );
  }
}


class CustomTheme  {

  static ThemeData theme() {

    return ThemeData(
      fontFamily: "MontserratRegular",
      brightness: Brightness.dark,
      scaffoldBackgroundColor: Colors.black,

      appBarTheme: AppBarTheme(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),

      colorScheme: ColorScheme.dark().copyWith(
        primary: Colors.white,
        secondary: Colors.grey,
      ),

      textTheme: TextTheme(
        bodyLarge: TextStyle(
          color: Colors.white,
        ),
        bodyMedium: TextStyle(
          color: Colors.white,
        ),
        titleLarge: TextStyle(
          color: Colors.white,
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(style: ElevatedButton.styleFrom(
        backgroundColor: Colors.grey[900],
        foregroundColor: Colors.white,
      )),
    );
  }
}