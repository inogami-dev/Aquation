// import 'package:aquation/ai/test_screen.dart';
import 'package:aquation/ai/ai_screen.dart';
import 'package:aquation/ai/tab.dart';
import 'package:aquation/theme/theme.dart';
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: aquationTheme,
      home: Scaffold(
        body: Center(
          // child: Text('Hello World!'),
          child: MyTabs(),
        ),
      ),
    );
  }
}
