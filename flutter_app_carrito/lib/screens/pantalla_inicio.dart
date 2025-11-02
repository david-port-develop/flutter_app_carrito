import '/data/datos_ejemplo.dart';
import '/screens/pantalla_carrito.dart';
import '/widgets/ficha_producto.dart';
import 'package:flutter/material.dart';
// Importa el proveedor de carrito para gestionar el estado del carrito de compras.
import '/providers/carrito_provider.dart';
import 'package:provider/provider.dart';

// Pantalla principal que muestra la lista de productos.
class PantallaInicio extends StatelessWidget {
  const PantallaInicio({super.key});

  @override
  Widget build(BuildContext context) {
    // Usamos Consumer para escuchar los cambios en CarritoProvider y reconstruir el icono.
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi Tienda'),
        actions: [
          Consumer<CarritoProvider>(
            builder: (context, carrito, child) {
              return IconButton(
                icon: Stack(
                  children: [
                    const Icon(Icons.shopping_cart),
                    // Si hay artículos, muestra el contador.
                    if (carrito.numeroDeArticulos > 0)
                      Positioned(
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(1),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          constraints: const BoxConstraints(
                            minWidth: 16,
                            minHeight: 16,
                          ),
                          child: Text(
                            carrito.numeroDeArticulos.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                  ],
                ),
                onPressed: () {
                  // Navega a la pantalla del carrito al pulsar el icono.
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const PantallaCarrito(),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(8.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Dos columnas
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
              // Añade el producto al carrito usando el Provider.
              // El 'listen: false' es importante aquí porque no necesitamos
              // que este widget se reconstruya cuando cambie el carrito.
              Provider.of<CarritoProvider>(
                context,
                listen: false,
              ).anadirProducto(producto);
            },
          );
        },
      ),
    );
  }
}
