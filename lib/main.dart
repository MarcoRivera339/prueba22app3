import 'package:app_supa/screens/LeerScreen.dart';
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

// Get a reference your Supabase client
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
      appBar: AppBar(),
      body: LeerScreen(),
    );
  }
}