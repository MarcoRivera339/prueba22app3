import 'package:app_supa/screens/LoginScreen.dart';
import 'package:app_supa/screens/RegisterScreen.dart';
import 'package:flutter/material.dart';

class Welcomescreen extends StatelessWidget {
  const Welcomescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Loginscreen()),
              );
            },
            child: const Text('Login'),
          ),

          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Registerscreen()),
              );
            },
            child: const Text('Registro'),
          ),
        ],
      ),
    );
  }
}
