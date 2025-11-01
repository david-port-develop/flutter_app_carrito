import '/data/datos_ejemplo.dart';
import '/screens/pantalla_carrito.dart';
import '/widgets/ficha_producto.dart';
import 'package:flutter/material.dart';

// Pantalla principal que muestra la lista de productos.
class PantallaInicio extends StatelessWidget {
  const PantallaInicio({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi Tienda'),
        actions: [
          IconButton(
            icon: Stack(
              children: [
                const Icon(Icons.shopping_cart),
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
                    child: const Text(
                      '0', // Valor de ejemplo
                      style: TextStyle(color: Colors.white, fontSize: 10),
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
              // La lógica para añadir al carrito se implementará en la Fase 2.
            },
          );
        },
      ),
    );
  }
}
