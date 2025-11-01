import '/screens/pantalla_inicio.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MiTiendaApp());
}

class MiTiendaApp extends StatelessWidget {
  const MiTiendaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App de Compras',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const PantallaInicio(),
    );
  }
}
