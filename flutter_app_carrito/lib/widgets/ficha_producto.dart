import '/models/producto.dart';
import 'package:flutter/material.dart';

// Widget reutilizable para mostrar un único producto en la parrilla.
class FichaProducto extends StatelessWidget {
  final Producto producto;
  final VoidCallback enAnadirAlCarrito;

  const FichaProducto({
    super.key,
    required this.producto,
    required this.enAnadirAlCarrito,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(child: Image.network(producto.imagenUrl, fit: BoxFit.cover)),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  producto.nombre,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  '\$${producto.precio.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ElevatedButton(
              onPressed: enAnadirAlCarrito,
              child: const Text('Añadir al carrito'),
            ),
          ),
        ],
      ),
    );
  }
}
