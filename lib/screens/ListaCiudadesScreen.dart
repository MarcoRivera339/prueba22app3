import 'dart:convert';
import 'package:flutter/material.dart';

class Listaciudadesscreen extends StatelessWidget {
  const Listaciudadesscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ciudades')),
      body: const ListaCiudades(),
    );
  }
}

class ListaCiudades extends StatelessWidget {
  const ListaCiudades({super.key});

  Future<List<dynamic>> leerCiudades(BuildContext context) async {
    final jsonString = await DefaultAssetBundle.of(context)
        .loadString('data/ciudades2.json');

    final data = json.decode(jsonString);
    return data['ciudades'];
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: leerCiudades(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return const Center(child: Text('Error al cargar datos'));
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No hay datos'));
        }

        final ciudades = snapshot.data!;

        return ListView.builder(
          itemCount: ciudades.length,
          itemBuilder: (context, index) {
            final ciudad = ciudades[index];
            final info = ciudad['informacion'];

            return ListTile(
              leading: Image.network(
                info['imagen'],
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
              title: Text(ciudad['nombre']),
              subtitle: Text(ciudad['provincia']),
              onTap: () => mostrarInfo(context, ciudad),
            );
          },
        );
      },
    );
  }
}

void mostrarInfo(BuildContext context, ciudad) {
  final info = ciudad['informacion'];

  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(ciudad['nombre']),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.network(info['imagen']),
            const SizedBox(height: 10),
            Text('Provincia: ${ciudad['provincia']}'),
            const SizedBox(height: 6),
            Text(ciudad['descripcion']),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cerrar'),
        ),
      ],
    ),
  );
}
