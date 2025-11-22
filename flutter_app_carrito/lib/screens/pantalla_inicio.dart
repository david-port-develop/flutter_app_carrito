import '/data/datos_ejemplo.dart';
import '/providers/carrito_provider.dart';
import '/widgets/app_bar_comun.dart';
import '/widgets/ficha_producto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Pantalla principal que muestra la lista de productos.
class PantallaInicio extends ConsumerWidget {
  const PantallaInicio({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const AppBarComun(),
      body: GridView.builder(
        padding: const EdgeInsets.all(8.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // Tres columnas
          childAspectRatio: 2 / 3,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: productosEjemplo.length,
        itemBuilder: (context, index) {
          final producto = productosEjemplo[index];
          return FichaProducto(
            producto: producto,
            enAnadirAlCarrito: () {
              ref.read(carritoProvider.notifier).agregarProducto(producto);
            },
          );
        },
      ),
    );
  }
}
