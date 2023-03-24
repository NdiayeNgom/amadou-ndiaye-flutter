import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../providers/ecole_provider.dart';

import 'ui/screens/cours/cours_list_screen.dart';
import '../providers/cours_provider.dart';
import 'ui/screens/auth/login_screen.dart';
import 'ui/screens/auth/register_screen.dart';
import 'ui/screens/cours/ajout_cours_screen.dart';
import 'ui/screens/cours/cours_detail_screen.dart';
import '../providers/auth_provider.dart';
import 'ui/screens/ecole/ajout_ecole_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final String? accessToken = prefs.getString('accessToken');
    return accessToken;
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    print(getToken());
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => EcoleProvider(),
        ),
        ChangeNotifierProxyProvider<AuthProvider, CoursProvider>(
          create: (_) => CoursProvider('', '', []),
          update: (ctx, auth, previousCours) => CoursProvider(
            auth.token!,
            auth.userId!,
            previousCours == null ? [] : previousCours.cours,
          ),
        ),
      ],
      child: Consumer<AuthProvider>(
        builder: (ctx, auth, _) => MaterialApp(
          title: 'Suivi et Evaluation des cours ',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: auth.isAuth ? const CoursListScreen() : const LoginScreen(),
          routes: {
            RegisterScreen.routeName: (context) => const RegisterScreen(),
            LoginScreen.routeName: (context) => const LoginScreen(),
            CoursDetailScreen.routeName: (context) => const CoursDetailScreen(),
            CoursListScreen.routeName: (context) => const CoursListScreen(),
            AjoutCoursScreen.routeName: (context) => AjoutCoursScreen(),
            AjoutEcoleScreen.routeName: (context) => AjoutEcoleScreen()
          },
        ),
      ),
    );
  }
}
