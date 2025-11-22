import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Un AppBar reutilizable para mantener la consistencia en la app.
class AppBarComun extends StatelessWidget implements PreferredSizeWidget {
  const AppBarComun({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // Evita que aparezca la flecha de 'atrás' automáticamente.
      automaticallyImplyLeading: false,
      // El título se alinea a la izquierda por defecto.
      title: const Text('Mi Tienda'),
      actions: [
        // Icono para navegar a la pantalla de inicio.
        IconButton(
          icon: const Icon(Icons.home),
          onPressed: () {
            context.go('/');
          },
        ),
        // Icono del carrito de compras con un contador.
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
                    '0',
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
