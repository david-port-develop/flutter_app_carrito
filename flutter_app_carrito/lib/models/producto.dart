// Cada producto tiene un nombre, un precio, una URL de imagen y una descripción opcional.
class Producto {
  final String nombre;
  final double precio;
  final String? imagenUrl; // La URL de la imagen también es opcional
  final String?
  descripcion; // La descripción ahora es opcional (puede ser nula)

  Producto({
    required this.nombre,
    required this.precio,
    this.imagenUrl, // Ya no es 'required'
    this.descripcion, // Ya no es 'required'
  });
}
