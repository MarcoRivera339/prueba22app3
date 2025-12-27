import 'package:app_supa/screens/WelcomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
//////////////////////////////////////////////////////////
Future<void> main() async {
  await Supabase.initialize(
    url: 'https://xiyamkzutmocckoixuyn.supabase.co',
    anonKey: 'sb_publishable_bo5mmcASmYr41NtLFozeyA_op62_sM2',
  );

  runApp(MiAplicacion());
}

final supabase = Supabase.instance.client;

///////////////////////////////////////////////////////////
class MiAplicacion extends StatelessWidget {
  const MiAplicacion({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Cuerpo(),
    );
  }
}

class Cuerpo extends StatelessWidget {
  const Cuerpo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Prueba 2"),),
      body: Welcomescreen(),
    );
  }
}