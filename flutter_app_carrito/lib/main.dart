import '/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  //Se añade ProviderScope para habilitar Riverpod en toda la app
  runApp(const ProviderScope(child: MiTiendaApp()));
}

class MiTiendaApp extends StatelessWidget {
  const MiTiendaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'App de Compras',
      theme: _buildTheme(context),
      routerConfig: appRouter,
    );
  }

  ThemeData _buildTheme(BuildContext context) {
    const primaryColor = Color(0xFF3D5A80);
    const secondaryColor = Color(0xFFEE6C4D);
    const backgroundColor = Color(0xFFF4F4F8);

    return ThemeData(
      useMaterial3: true,
      primaryColor: primaryColor,
      scaffoldBackgroundColor: backgroundColor,
      // Define la paleta de colores general
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        secondary: secondaryColor,
        surface: backgroundColor,
        brightness: Brightness.light,
      ),
      // Define la tipografía para toda la app
      textTheme: GoogleFonts.montserratTextTheme(Theme.of(context).textTheme),
      // Estilo para el AppBar
      appBarTheme: AppBarTheme(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white, // Color para el título y los iconos
        elevation: 2,
        titleTextStyle: GoogleFonts.montserrat(
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      // Estilo para los botones elevados
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: secondaryColor, // Color de fondo del botón
          foregroundColor: Colors.white, // Color del texto del botón
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
      ),
    );
  }
}
