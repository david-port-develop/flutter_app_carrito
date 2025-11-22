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
      elevation: 3,
      color: Colors.lightBlue[50],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Stack(
              fit: StackFit.expand,
              children: [
                // Si la URL de la imagen existe y no está vacía, muéstrala.
                if (producto.imagenUrl != null &&
                    producto.imagenUrl!.isNotEmpty)
                  Image.network(producto.imagenUrl!, fit: BoxFit.cover)
                // Si no, muestra un placeholder.
                else
                  const Center(
                    child: Icon(
                      Icons.image_not_supported,
                      size: 50,
                      color: Colors.grey,
                    ),
                  ),
                Positioned(
                  top: 20,
                  right: 20,
                  child: CircleAvatar(
                    radius: 25, // Aumenta el tamaño del círculo
                    backgroundColor: const Color.fromARGB(137, 255, 255, 255),
                    child: IconButton(
                      icon: const Icon(
                        size: 30, // Aumenta el tamaño del ícono
                        Icons.add_shopping_cart,
                        color: Colors.red,
                      ),
                      onPressed: enAnadirAlCarrito,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  producto.nombre,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                // Muestra la descripción solo si existe y no está vacía.
                if (producto.descripcion != null &&
                    producto.descripcion!.isNotEmpty)
                  Text(
                    producto
                        .descripcion!, // Usamos '!' porque ya comprobamos que no es nulo.
                    style: Theme.of(context).textTheme.bodySmall,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                Text(
                  '\$${producto.precio.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
