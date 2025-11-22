import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
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

    // --- Manejo del Carrito Vacío ---
    if (articulosCarrito.isEmpty) {
      return Scaffold(
        appBar: const AppBarComun(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.remove_shopping_cart_outlined,
                size: 80,
                color: Colors.grey[400],
              ),
              const SizedBox(height: 20),
              Text(
                'Tu carrito está vacío',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 10),
              const Text(
                '¡Añade productos para verlos aquí!',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () => context.go('/'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 15,
                  ),
                ),
                child: const Text('Ir a la tienda'),
              ),
            ],
          ),
        ),
      );
    }

    // --- Vista del Carrito con Productos ---
    return Scaffold(
      appBar: const AppBarComun(),
      body: Column(
        children: [
          Expanded(
            // Usamos ListView.separated para añadir un espacio entre tarjetas.
            child: ListView.separated(
              padding: const EdgeInsets.all(8.0),
              itemCount: articulosCarrito.length,
              separatorBuilder: (context, index) => const SizedBox(height: 8.0),
              itemBuilder: (context, index) {
                final item = articulosCarrito[index];
                // --- Tarjeta de Producto Mejorada ---
                return Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        // Imagen del producto con bordes redondeados
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child:
                              (item.producto.imagenUrl != null &&
                                  item.producto.imagenUrl!.isNotEmpty)
                              ? Image.network(
                                  item.producto.imagenUrl!,
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                )
                              : Container(
                                  width: 80,
                                  height: 80,
                                  color: Colors.grey[200],
                                  child: const Icon(
                                    Icons.image_not_supported,
                                    size: 40,
                                    color: Colors.grey,
                                  ),
                                ),
                        ),
                        const SizedBox(width: 15),
                        // Nombre y precio unitario
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.producto.nombre,
                                style: Theme.of(context).textTheme.titleMedium,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 5),
                              Text(
                                '\$${item.producto.precio.toStringAsFixed(2)} c/u',
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        // Controles de cantidad
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove_circle_outline),
                              onPressed: () => ref
                                  .read(carritoProvider.notifier)
                                  .disminuirCantidad(item.producto.nombre),
                            ),
                            Text(
                              item.cantidad.toString(),
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            IconButton(
                              icon: const Icon(Icons.add_circle_outline),
                              onPressed: () => ref
                                  .read(carritoProvider.notifier)
                                  .aumentarCantidad(item.producto.nombre),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          // --- Resumen del Pedido y Botón ---
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 0,
                  blurRadius: 10,
                ),
              ],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
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
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Lógica de aprobación
                    },
                    child: const Text('Aprobar Pedido'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
