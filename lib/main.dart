import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:social_media_app/screens/auth/sign_in.dart';
import 'package:social_media_app/screens/auth/sign_up.dart';
import 'package:social_media_app/screens/home/home.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'injection.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  await Supabase.initialize(
    url: dotenv.env['url'] ?? '',
    anonKey: dotenv.env['anonkey'] ?? '',
    authFlowType: AuthFlowType.pkce,
  );
  await init(); // ensuring dependency injection

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SignInScreen(),
      routes: {
        '/toSignInScreen': (context) => const SignInScreen(),
        '/toSignUpScreen': (context) => const WelcomeScreen(),
        '/toMyFeed': (context) => const Home(),
      },
    );
  }
}
