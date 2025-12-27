import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:app_supa/main.dart';
import 'LoginScreen.dart';

class Gastronomiascreen extends StatelessWidget {
  const Gastronomiascreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Supabase.instance.client.auth.currentUser;

    // 🔐 Protección de sesión
    if (user == null) {
      return const Loginscreen();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Platillo típico'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await Supabase.instance.client.auth.signOut();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const Loginscreen()),
                (route) => false,
              );
            },
          ),
        ],
      ),
      body: formulario(),
    );
  }
}

Widget formulario() {
  final TextEditingController idPlatillo = TextEditingController();
  final TextEditingController platillo = TextEditingController();
  final TextEditingController ciudad = TextEditingController();

  return Padding(
    padding: const EdgeInsets.all(16),
    child: Column(
      children: [
        TextField(
          controller: idPlatillo,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: 'ID del platillo',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 10),

        TextField(
          controller: platillo,
          decoration: const InputDecoration(
            labelText: 'Platillo típico',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 10),

        TextField(
          controller: ciudad,
          decoration: const InputDecoration(
            labelText: 'Ciudad',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 20),

        FilledButton(
          onPressed: () => guardarPlatillo(idPlatillo, platillo, ciudad),
          child: const Text('Guardar'),
        ),
      ],
    ),
  );
}

Future<void> guardarPlatillo(
  TextEditingController idPlatillo,
  TextEditingController platillo,
  TextEditingController ciudad,
) async {
  try {
    final user = Supabase.instance.client.auth.currentUser;

    if (user == null) {
      throw 'Usuario no autenticado';
    }

    await supabase.from('platillos').insert({
      'id_platillo': int.parse(idPlatillo.text.trim()),
      'platillo': platillo.text.trim(),
      'ciudad': ciudad.text.trim(),
      'correo': user.email,
    });

  } catch (e) {
    print(' Error');
  }
}
