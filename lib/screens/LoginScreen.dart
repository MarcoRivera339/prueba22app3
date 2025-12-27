import 'package:app_supa/navigation/BottonTabNavigator.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Loginscreen extends StatelessWidget {
  const Loginscreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController correo = TextEditingController();
    TextEditingController contrasenia = TextEditingController();

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: correo,
            decoration: const InputDecoration(hintText: 'Correo'),
          ),

          TextField(
            controller: contrasenia,
            obscureText: true,
            decoration: const InputDecoration(hintText: 'Contraseña'),
          ),

          ElevatedButton(
            onPressed: () async {
              bool ok = await login(context, correo, contrasenia);

              if (ok) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Bottomtabnavigator(),
                  ),
                );
              }
            },
            child: const Text('Login'),
          ),
        ],
      ),
    );
  }
}

Future<bool> login(BuildContext context, correo, contrasenia) async {
  try {
    final response = await Supabase.instance.client.auth.signInWithPassword(
      email: correo.text.trim(),
      password: contrasenia.text,
    );

    if (response.user == null) {
      return false;
    }

    return true; // login correcto
  } catch (e) {
    String mensaje = 'Ocurrió un error inesperado';

    final error = e.toString().toLowerCase();

    if (error.contains('invalid login credentials')) {
      mensaje = 'El correo o la contraseña no son correctos.';
    } else if (error.contains('email')) {
      mensaje = 'El formato del correo es inválido.';
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error de inicio de sesión'),
        content: Text(mensaje),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Aceptar'),
          ),
        ],
      ),
    );

    return false;
  }
}
