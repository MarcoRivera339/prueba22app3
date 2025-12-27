import 'package:app_supa/screens/GastronomiaScreen.dart';
import 'package:app_supa/screens/ListaCiudadesScreen.dart';
import 'package:flutter/material.dart';

class Bottomtabnavigator extends StatefulWidget {
  const Bottomtabnavigator({super.key});

  @override
  State<Bottomtabnavigator> createState() => _BottomtabnavigatorState();
}

class _BottomtabnavigatorState extends State<Bottomtabnavigator> {
  int _indiceActual = 0;

  final List<Widget> _pantallas = const [
    Gastronomiascreen(),
    Listaciudadesscreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pantallas[_indiceActual],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _indiceActual,
        onTap: (index) {
          setState(() {
            _indiceActual = index;
          });
        },
        type: BottomNavigationBarType.fixed,

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant),
            label: 'Gastronomía',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_city),
            label: 'Ciudades',
          ),
        ],
      ),
    );
  }
}
