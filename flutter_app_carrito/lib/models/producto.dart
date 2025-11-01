// Define el modelo de datos para un producto.
// Cada producto tiene un nombre, un precio y una URL para su imagen.
class Producto {
  final String nombre;
  final double precio;
  final String imagenUrl;

  Producto({
    required this.nombre,
    required this.precio,
    required this.imagenUrl,
  });
}
