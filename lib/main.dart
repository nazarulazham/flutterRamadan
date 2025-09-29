import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'services/auth_service.dart';
import 'screens/auth_wrapper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyDiTuJZ4ieL71hBGqaF0CziozqPgPYaziU",
  authDomain: "ramadan-todak.firebaseapp.com",
  projectId: "ramadan-todak",
  storageBucket: "ramadan-todak.appspot.com",
  messagingSenderId: "511448002405",
  appId: "1:511448002405:web:fb48bee5e8f208a49e3b8c"
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<User?>.value(
          value: AuthService().userStream,
          initialData: null,
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Ramadan Companion',
        home: const AuthWrapper(),
      ),
    );
  }
}
