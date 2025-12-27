import 'package:app_supa/main.dart';
import 'package:flutter/material.dart';


class LeerScreen extends StatelessWidget {
  const LeerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(), body: lista());
  }
}

//leer la lista
Future<List<dynamic>> leerLista() async {
  final data = await supabase.from('auto').select();
  return data;
}

//ver lista
Widget lista() {
  return FutureBuilder(
    future: leerLista(),
    builder: (context, snapshot) {
      //snapshot almance ala inf de leerlista, ! para evitar datos nulos
      if (snapshot.hasData) {
        List data = snapshot.data!;
        return ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            final item = data[index];

            return ListTile(
              title: Text(item['placa']),
              subtitle: Text("MARCA: ${item['marca']}"),
              onTap: () => editar(context),
              leading: Icon(Icons.car_rental),
              trailing: IconButton(
                onPressed: () => eliminar(item['placa']),
                icon: Icon(Icons.delete),
              ),
            );
          },
        );
      } else {
        return Text("No hay data");
      }
    },
  );
}

//eliminar lista
Future<void> eliminar(placa) async {
  await supabase.from('auto').delete().eq('placa', placa);
}

//editar
Future<void> editar(context) async {
  await supabase
  .from('auto')
  .update({ 'marca': '' })
  .eq('id', 1);
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text("Editar"),
        content: Container(
          height: 200,
          child: Column(
            children: [
              TextField(),
              TextField(),
              ElevatedButton(onPressed: () => (), child: Text("Editar")),
            ],
          ),
        ),
      );
    },
  );
}
