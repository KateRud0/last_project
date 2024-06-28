import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart';
import 'screens/category_task_screen.dart';
import 'screens/task_detail_screen.dart';
import 'screens/settings_screen.dart';
import 'providers.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CategoryProvider()),
        ChangeNotifierProvider(create: (_) => TaskProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'To-do List',
            theme: ThemeData.light(),
            darkTheme: ThemeData.dark(),
            themeMode: themeProvider.themeMode,
            initialRoute: '/',
            routes: {
              '/': (context) => HomeScreen(),
              CategoryTaskScreen.routeName: (context) => CategoryTaskScreen(),
              TaskDetailScreen.routeName: (context) => TaskDetailScreen(),
              SettingsScreen.routeName: (context) => SettingsScreen(),
            },
          );
        },
      ),
    );
  }
}
