import 'package:flutter/material.dart';
import 'package:app_supa/main.dart';

class Registerscreen extends StatelessWidget {
  const Registerscreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController correo = TextEditingController();
    final TextEditingController contrasenia = TextEditingController();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: correo,
              decoration: const InputDecoration(
                hintText: 'Correo',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),

            TextField(
              controller: contrasenia,
              obscureText: true,
              decoration: const InputDecoration(
                hintText: 'Contraseña',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () => registrar(context, correo, contrasenia),
              child: const Text('Registrarse'),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> registrar(
  BuildContext context,
  TextEditingController correo,
  TextEditingController contrasenia,
) async {
  try {
    // 1️⃣ Registrar en Supabase Auth
    final response = await supabase.auth.signUp(
      email: correo.text.trim(),
      password: contrasenia.text.trim(),
    );

    final user = response.user;

    if (user == null) {
      throw 'No se pudo crear el usuario';
    }

    // 2️⃣ Guardar en tabla usuarios
    await supabase.from('usuarios').insert({
      'id': user.id, // UUID del auth
      'correo': user.email, // correo del usuario
    });

    debugPrint('✅ Usuario guardado correctamente');

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Registro exitoso')));
  } catch (e) {
    debugPrint('❌ Error al registrar: $e');

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Error: $e')));
  }
}
