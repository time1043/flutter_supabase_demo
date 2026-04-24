import 'package:flutter/material.dart';
import 'package:flutter_supabase_demo/pages/account_page.dart';
import 'package:flutter_supabase_demo/pages/login_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// https://supabase.com/docs/guides/getting-started/tutorials/with-flutter
/// https://github.com/orgs/supabase/discussions/12530
///
/// More resources
/// https://supabase.com/blog/flutter-tutorial-building-a-chat-app
/// https://supabase.com/blog/flutter-authorization-with-rls

Future<void> main() async {
  // flutter run -d web-server --web-hostname localhost --web-port 3000
  // flutter run --dart-define-from-file=config.json
  const String supabaseUrl = String.fromEnvironment('SUPABASE_URL');
  const String supabaseAnonKey = String.fromEnvironment('SUPABASE_ANON_KEY');
  await Supabase.initialize(url: supabaseUrl, anonKey: supabaseAnonKey);
  runApp(const MainApp());
}

final supabase = Supabase.instance.client;

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Supabase Flutter',
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.green,
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(foregroundColor: Colors.green),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.green,
          ),
        ),
      ),
      home: supabase.auth.currentSession == null
          ? const LoginPage()
          : const AccountPage(),
    );
  }
}

extension ContextExtension on BuildContext {
  void showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError
            ? Theme.of(this).colorScheme.error
            : Theme.of(this).snackBarTheme.backgroundColor,
      ),
    );
  }
}
