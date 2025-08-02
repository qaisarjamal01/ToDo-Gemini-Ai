import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/providers/theme_provider.dart';

class ThemeSwitcher extends StatelessWidget {
  const ThemeSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        final isDark = themeProvider.themeMode == ThemeMode.dark;
        return Switch(
          value: isDark,
          onChanged: (value) {
            themeProvider.toggleTheme();
          },
          activeColor: Theme.of(context).primaryColor,
          inactiveThumbColor: Colors.grey,
        );
      },
    );
  }
}