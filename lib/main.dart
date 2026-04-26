import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/selector_colores_estado.dart';
import 'viewmodels/selector_colores_viewmodel.dart';
import 'views/pantalla.dart';

/// Función principal que arranca la aplicación Flutter.
void main() {
  runApp(
    // 1. Envolvemos la app en el Provider para la arquitectura MVVM
    ChangeNotifierProvider(
      create: (context) {
        // 2. Instanciamos el estado inicial (Desacoplamiento)
        const estadoInicial = ColorSelectorState();
        // 3. Inyectamos el estado en el ViewModel
        return ColorSelectorViewModel(estadoInicial);
      },
      child: const MiAppSelectorColor(),
    ),
  );
}

/// Widget raíz de la aplicación.
class MiAppSelectorColor extends StatelessWidget {
  const MiAppSelectorColor({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Selector de Color HSL',
      theme: ThemeData(primarySwatch: Colors.blue),
      // Cargamos la pantalla principal que crearemos a continuación
      home: const MainScreen(),
    );
  }
}
