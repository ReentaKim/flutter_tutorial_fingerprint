import 'package:flutter/material.dart';
import 'package:flutter_tutorial_fingerprint/home/view/home_screen.dart';
import 'package:local_auth/local_auth.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final LocalAuthentication _auth = LocalAuthentication();

  checkAuthentication() async {
    bool isAvailable;
    isAvailable = await _auth.canCheckBiometrics;
    print(isAvailable);

    if (isAvailable) {
      bool result = await _auth.authenticate(
        options: const AuthenticationOptions(),
        localizedReason: 'Scan your finger to proceed',
      );

      if (result) {
        if (mounted) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => const HomeScreen(),
            ),
          );
        }
      } else {
        print('Permission Denied!');
      }
    } else {
      print('Biometrics not available');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Center(
        child: ElevatedButton.icon(
          onPressed: checkAuthentication,
          icon: Icon(Icons.fingerprint_outlined),
          label: Text('finger print'),
        ),
      ),
    );
  }
}
