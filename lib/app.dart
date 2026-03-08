import 'package:flutter/material.dart';
import 'package:innolab_application/features/authentication/screens/admin_login_screen.dart';
import 'package:innolab_application/utils/theme/theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system,
      theme: ATheme.lightTheme,
      darkTheme: ATheme.darkTheme,
      home: const AdminLoginScreen(),
    );
  }
}
