import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/articulo_carrito.dart';
import '../models/producto.dart';

//Usamos la clase Notificadora de Estado usando el 'Notifier'
class CarritoNotifier extends Notifier<List<ArticuloCarrito>> {
  @override
  List<ArticuloCarrito> build() {
    return [];
  }

  // Método para añadir un producto al carrito.
  void agregarProducto(Producto producto) {
    // Busca si el producto ya existe en el carrito.
    final indice = state.indexWhere(
      (item) => item.producto.nombre == producto.nombre,
    );

    if (indice != -1) {
      // Si existe, crea una copia del artículo y aumenta su cantidad.
      final articuloExistente = state[indice];
      final articuloActualizado = ArticuloCarrito(
        producto: articuloExistente.producto,
        cantidad: articuloExistente.cantidad + 1,
      );
      // Reemplaza el artículo antiguo por el actualizado en la lista.
      state = [
        for (int i = 0; i < state.length; i++)
          if (i == indice) articuloActualizado else state[i],
      ];
    } else {
      // Si no existe, añade un nuevo artículo al carrito.
      state = [...state, ArticuloCarrito(producto: producto, cantidad: 1)];
    }
  }

  // Método para eliminar un producto del carrito.
  void eliminarProducto(String nombreProducto) {
    state = state
        .where((item) => item.producto.nombre != nombreProducto)
        .toList();
  }
}

// 2. Define el Proveedor (StateNotifierProvider)
// Se define el proveedor usando 'NotifierProvider'.
// La sintaxis es más directa y concisa que con StateNotifierProvider.
final carritoProvider =
    NotifierProvider<CarritoNotifier, List<ArticuloCarrito>>(
      CarritoNotifier.new,
    );
