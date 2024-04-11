import 'package:anime_flut/ui/pages/pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isFirstTime = prefs.getBool('first_time') ?? true;

  runApp(MyApp(isFirstTime: isFirstTime));
}

class MyApp extends StatelessWidget {
  final bool isFirstTime;
  const MyApp({Key? key, required this.isFirstTime}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: isFirstTime ? SplashPage() : _getLandingPage(),
    );
  }

  Widget _getLandingPage() {
    // Periksa status login pengguna
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // Jika sudah login, tampilkan halaman dashboard
      return Wrapper();
    } else {
      // Jika belum login, tampilkan halaman login
      return LoginPage();
    }
  }
}
