import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '/screens/pantalla_inicio.dart';
import '/screens/pantalla_carrito.dart';

// Configuración centralizada de las rutas de la aplicación usando go_router.
final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    // Ruta para la pantalla de inicio.
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const PantallaInicio();
      },
    ),
    // Ruta para la pantalla del carrito.
    GoRoute(
      path: '/carrito',
      builder: (BuildContext context, GoRouterState state) {
        return const PantallaCarrito();
      },
    ),
  ],
);
