import '/models/articulo_carrito.dart';
import '/data/datos_ejemplo.dart';
import 'package:flutter/material.dart';

// Pantalla que muestra el contenido del carrito de compras.
class PantallaCarrito extends StatefulWidget {
  const PantallaCarrito({super.key});

  @override
  _PantallaCarritoState createState() => _PantallaCarritoState();
}

class _PantallaCarritoState extends State<PantallaCarrito> {
  // Datos de ejemplo para el carrito
  final List<ArticuloCarrito> _articulosCarrito = [
    ArticuloCarrito(producto: productosEjemplo[0], cantidad: 2),
    ArticuloCarrito(producto: productosEjemplo[1], cantidad: 1),
  ];

  // Calcula el precio total de los artículos en el carrito.
  double get _precioTotal {
    return _articulosCarrito.fold(
      0,
      (sum, item) => sum + (item.producto.precio * item.cantidad),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mi Carrito')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _articulosCarrito.length,
              itemBuilder: (context, index) {
                final item = _articulosCarrito[index];
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
                          // La lógica para eliminar se implementará en la Fase 2.
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
                  '\$${_precioTotal.toStringAsFixed(2)}',
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
