import 'package:flutter/material.dart';
import 'package:possmartnew/firebase_services/splash_services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashServices splashscreen = SplashServices();
  @override
  void initState() {
    super.initState();
    splashscreen.isLogin(context);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/poslogo.jpg', // Use the image from assets
              width: 150,
            ),
            SizedBox(height: 16),
            Text(
              'Smart Online Point of Sale',
              style: TextStyle(
                color: Colors.white, // Customize the color of the text
                fontSize: 24, // Customize the font size of the text
                fontWeight:
                    FontWeight.bold, // Customize the font weight of the text
              ),
            ),
          ],
        ),
      ),
    );
  }
}
