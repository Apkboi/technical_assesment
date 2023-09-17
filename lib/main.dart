import 'package:flutter/material.dart';
import 'package:technical_assesment/core/di/injector.dart' as di;
import 'package:technical_assesment/core/theme/app_text_theme.dart';
import 'package:technical_assesment/core/theme/app_theme.dart';
import 'package:technical_assesment/core/utils/app_utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await di.init();
  final nextScreen = await AppUtils.getFirstScreen();

  runApp(MyApp(
    nextScreen: nextScreen,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.nextScreen});

  final Widget nextScreen;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: appColorScheme.background,
        colorScheme: appColorScheme,
        textTheme: appTextTheme,
        useMaterial3: true,
      ),
      home: nextScreen,
    );
  }
}
