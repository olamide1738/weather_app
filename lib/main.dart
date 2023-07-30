import 'package:flutter/material.dart';
import 'package:weather_app/weather_screen.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Weather App',
        theme: ThemeData(
         
          appBarTheme:
              AppBarTheme(color: Colors.white, surfaceTintColor: Colors.white),
          hintColor: Colors.blueGrey,
          primaryColorLight: Colors.black,
          dividerColor: Colors.black,
          primaryColor: Colors.blue.shade800,
          primaryColorDark: Colors.white,
          colorScheme: ColorScheme.light(background: Colors.white),
          useMaterial3: true,
        ),
        darkTheme: ThemeData(
            progressIndicatorTheme: ProgressIndicatorThemeData(
                circularTrackColor: Colors.blue.shade800),
            appBarTheme: AppBarTheme(
                backgroundColor: Colors.black, surfaceTintColor: Colors.black),
            hintColor: Colors.grey.shade600,
            primaryColorLight: Colors.white,
            dividerColor: Colors.white,
            useMaterial3: true,
            colorScheme: ColorScheme.dark(background: Colors.black)),
        themeMode: ThemeMode.system,
        home: WeatherScreen());
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({
    super.key,
  });

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MaterialApp(
      home: WeatherScreen(),
    );
  }
}
