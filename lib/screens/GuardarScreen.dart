import 'package:app_supa/main.dart';
import 'package:flutter/material.dart';

class GuardarScreen extends StatelessWidget {
  const GuardarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(), body: formulario());
  }
}

Widget formulario() {
  TextEditingController placa = TextEditingController();
  TextEditingController marca = TextEditingController();
  TextEditingController precio = TextEditingController();

  return Column(
    children: [
      TextField(
        controller: placa,
        decoration: InputDecoration(label: Text("Ingresar placa")),
      ),
      TextField(
        controller: marca,
        decoration: InputDecoration(label: Text("Ingresar marca")),
      ),
      TextField(
        controller: precio,
        decoration: InputDecoration(label: Text("Ingresar precio")),
      ),
      FilledButton(
        onPressed: () => guardar(placa, marca, precio),
        child: Text("Guardar"),
      ),
    ],
  );
}

Future<void> guardar(placa, marca, precio) async {
  await supabase.from('auto').insert({
    'placa': placa.text,
    'marca': marca.text,
    'precio': precio.text,
  });
}
