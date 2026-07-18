// import 'package:aquation/ai/test_screen.dart';
import 'package:aquation/ai/test_screen.dart';
import 'package:aquation/pages/dashboard_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Load the hidden variables
  await dotenv.load(fileName: ".env");
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // // Add this App Check activation block
  // await FirebaseAppCheck.instance.activate(
  
  //   // The new standard for Android testing
  //   providerAndroid: AndroidDebugProvider(),

  //   // The new standard for Web testing
  //   providerWeb: WebDebugProvider(),
  // );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          // child: Text('Hello World!'),
          child: DashboardPage(),
        ),
      ),
    );
  }
}
