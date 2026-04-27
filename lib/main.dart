import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/selector_colores_estado.dart';
import 'viewmodels/selector_colores_viewmodel.dart';
import 'views/screen_instalacion.dart'; // Empezamos por la instalación

/// Función principal que arranca la aplicación Flutter.
void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) {
        // 1. Instanciamos el estado inicial
        const estadoInicial = ColorSelectorState();
        // 2. Lo inyectamos en el ViewModel
        return ColorSelectorViewModel(estadoInicial);
      },
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        // Según tus apuntes de RA 7, la app arranca pidiendo la carpeta:
        home: SetupScreen(),
      ),
    ),
  );
}