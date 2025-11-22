import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/carrito_provider.dart';
import '../widgets/app_bar_comun.dart';
import 'package:flutter/material.dart';

// Pantalla que muestra el contenido del carrito de compras.
class PantallaCarrito extends ConsumerWidget {
  const PantallaCarrito({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final articulosCarrito = ref.watch(carritoProvider);
    final precioTotal = articulosCarrito.fold(
      0.0,
      (sum, item) => sum + (item.producto.precio * item.cantidad),
    );
    return Scaffold(
      appBar: const AppBarComun(),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: articulosCarrito.length,
              itemBuilder: (context, index) {
                final item = articulosCarrito[index];
                return ListTile(
                  leading:
                      (item.producto.imagenUrl != null &&
                          item.producto.imagenUrl!.isNotEmpty)
                      ? Image.network(
                          item.producto.imagenUrl!,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        )
                      : const Icon(Icons.image_not_supported, size: 50),
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
                          ref
                              .read(carritoProvider.notifier)
                              .eliminarProducto(item.producto.nombre);
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
                  '\$${precioTotal.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ],
            ),
          ),
          // Botón para aprobar el pedido.
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
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
