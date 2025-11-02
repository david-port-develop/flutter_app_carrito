import '/screens/pantalla_inicio.dart';
import 'package:flutter/material.dart';

import '/providers/carrito_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MiTiendaApp());
}

class MiTiendaApp extends StatelessWidget {
  const MiTiendaApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Usamos ChangeNotifierProvider para que el estado del carrito
    // esté disponible en toda la aplicación.
    return ChangeNotifierProvider(
      create: (context) => CarritoProvider(),
      child: MaterialApp(
        title: 'Mi tienda',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const PantallaInicio(),
      ),
    );
  }
}
