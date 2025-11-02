import '/models/articulo_carrito.dart';
import '/models/producto.dart';
import 'package:flutter/material.dart';

// Gestiona el estado del carrito de compras.
// Utiliza ChangeNotifier para notificar a los widgets cuando hay cambios.
class CarritoProvider with ChangeNotifier {
  // Mapa para almacenar los artículos del carrito, usando el nombre del producto como clave.
  final Map<String, ArticuloCarrito> _articulos = {};

  // Getter para acceder a la lista de artículos del carrito.
  List<ArticuloCarrito> get articulos => _articulos.values.toList();

  // Getter para calcular el número total de artículos en el carrito.
  int get numeroDeArticulos {
    return _articulos.values.fold(0, (sum, item) => sum + item.cantidad);
  }

  // Getter para calcular el precio total del carrito.
  double get precioTotal {
    return _articulos.values.fold(
      0,
      (sum, item) => sum + (item.producto.precio * item.cantidad),
    );
  }

  // Método para añadir un producto al carrito.
  void anadirProducto(Producto producto) {
    if (_articulos.containsKey(producto.nombre)) {
      // Si el producto ya está en el carrito, incrementa la cantidad.
      _articulos.update(
        producto.nombre,
        (articuloExistente) => ArticuloCarrito(
          producto: articuloExistente.producto,
          cantidad: articuloExistente.cantidad + 1,
        ),
      );
    } else {
      // Si es un producto nuevo, lo añade al carrito.
      _articulos.putIfAbsent(
        producto.nombre,
        () => ArticuloCarrito(producto: producto, cantidad: 1),
      );
    }
    // Notifica a los widgets que escuchan para que se reconstruyan.
    notifyListeners();
  }

  // Método para eliminar un artículo completo del carrito.
  void eliminarArticulo(String nombreProducto) {
    _articulos.remove(nombreProducto);
    notifyListeners();
  }

  // Método para reducir la cantidad de un artículo en uno.
  // Si la cantidad llega a cero, el artículo se elimina.
  void reducirCantidad(String nombreProducto) {
    if (!_articulos.containsKey(nombreProducto)) return;

    if (_articulos[nombreProducto]!.cantidad > 1) {
      _articulos.update(
        nombreProducto,
        (articuloExistente) => ArticuloCarrito(
          producto: articuloExistente.producto,
          cantidad: articuloExistente.cantidad - 1,
        ),
      );
    } else {
      _articulos.remove(nombreProducto);
    }
    notifyListeners();
  }
}
