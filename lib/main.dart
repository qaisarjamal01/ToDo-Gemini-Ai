import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_gemini_ai/app/routes/app_router.dart';
import 'app/core/themes/app_theme.dart';
import 'app/data/providers/theme_provider.dart';
import 'app/data/providers/todo_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => TodoProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'Todo App',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeProvider.themeMode,
          initialRoute: AppRouter.homeRoute,
          onGenerateRoute: AppRouter.generateRoute,
        );
      },
    );
  }
}