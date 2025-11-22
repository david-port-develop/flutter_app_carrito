import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/carrito_provider.dart';

// Un AppBar reutilizable para mantener la consistencia en la app.
class AppBarComun extends ConsumerWidget implements PreferredSizeWidget {
  const AppBarComun({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final articulosCarrito = ref.watch(carritoProvider);
    final totalArticulos = articulosCarrito.fold(
      0,
      (sum, item) => sum + item.cantidad,
    );
    return AppBar(
      // Evita que aparezca la flecha de 'atrás' automáticamente.
      automaticallyImplyLeading: false,
      title: const Text('Mi Tienda'),
      actions: [
        IconButton(
          icon: const Icon(Icons.home),
          onPressed: () {
            context.go('/');
          },
        ),
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
                  child: Text(
                    totalArticulos.toString(),
                    style: TextStyle(color: Colors.white, fontSize: 10),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
          onPressed: () => context.push('/carrito'),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
