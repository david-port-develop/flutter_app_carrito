import '/providers/carrito_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Pantalla que muestra el contenido del carrito de compras.
class PantallaCarrito extends StatelessWidget {
  const PantallaCarrito({super.key});

  @override
  Widget build(BuildContext context) {
    // Escuchamos los cambios en el CarritoProvider para reconstruir la UI.
    final carrito = Provider.of<CarritoProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Mi Carrito')),
      body: Column(
        children: [
          Expanded(
            // Si el carrito está vacío, muestra un mensaje.
            child: carrito.articulos.isEmpty
                ? const Center(child: Text('Tu carrito está vacío.'))
                : ListView.builder(
                    itemCount: carrito.articulos.length,
                    itemBuilder: (context, index) {
                      final item = carrito.articulos[index];
                      return ListTile(
                        leading: Image.network(
                          item.producto.imagenUrl,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                        title: Text(item.producto.nombre),
                        subtitle: Text('Cantidad: ${item.cantidad}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '\$${(item.producto.precio * item.cantidad).toStringAsFixed(2)}',
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                // Llama al método para eliminar el artículo del carrito.
                                carrito.eliminarArticulo(item.producto.nombre);
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
          // Muestra el resumen del precio total.
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total:',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                Text(
                  '\$${carrito.precioTotal.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ],
            ),
          ),
          // Botón para aprobar el pedido, se deshabilita si el carrito está vacío.
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: carrito.articulos.isEmpty
                    ? null // Deshabilitado si no hay artículos
                    : () {
                        // La lógica de aprobación se implementará en fases posteriores.
                      },
                child: const Text('Aprobar Pedido'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
