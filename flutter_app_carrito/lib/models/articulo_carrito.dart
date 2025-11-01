import 'producto.dart';

// Define un artículo dentro del carrito de compras.
// Contiene el producto y la cantidad de unidades de ese producto.
class ArticuloCarrito {
  final Producto producto;
  int cantidad;

  ArticuloCarrito({required this.producto, this.cantidad = 1});
}
