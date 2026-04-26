import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/selector_colores_estado.dart';
import 'viewmodels/selector_colores_viewmodel.dart';
import 'widgets/selector_colores_widget.dart';
import 'views/pantalla.dart';
import 'views/screen_instalacion.dart';

/// Función principal que arranca la aplicación Flutter.
void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) {
        const estadoInicial = ColorSelectorState();
        return ColorSelectorViewModel(estadoInicial);
      },
      // El MaterialApp debe ir aquí, envolviendo a tu widget raíz
      child: const MaterialApp(
        home: SetupScreen(),
      ),
    ),
  );
}
/// Widget raíz de la aplicación.
class MiAppSelectorColor extends StatelessWidget {
  const MiAppSelectorColor({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. LECTURA DEL ESTADO: Nos suscribimos al ViewModel [6]
    final vm = context.watch<ColorSelectorViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Práctica: Selector HSL'),
      ),
      // 2. ANIMATED CONTAINER: Envolvemos el body para animar el fondo [5]
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        color: vm.state.currentColor,

        child: Center(
          child: Container(
            // 1. CONSTRAINTS: Tamaño estricto de la caja
            width: 400,
            height: 500, // Ajustado a 500 ahora que no hay texto
            padding: const EdgeInsets.all(20),

            // 2. BOX DECORATION: Fondo de la caja interior
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.85),
                borderRadius: BorderRadius.circular(15),
                boxShadow: const [
                  BoxShadow(color: Colors.black26, blurRadius: 10, offset: Offset(0, 5))
                ]
            ),

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // TU CUSTOM WIDGET (Sin el texto arriba)
                ColorSelectorWidget(
                  state: vm.state,
                  size: 300,
                  borderColor: Colors.blueGrey,
                  onColorSelect: (Color nuevoColor, double x, double y) {
                    vm.selectColor(nuevoColor, x, y);
                  },
                  onReset: () {
                    vm.resetSelector();
                  },
                  onStartFrom: (Color colorInicial) {
                    vm.startFromColor(colorInicial);
                  },
                ),

                const SizedBox(height: 40),

                // Botones de control
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () => vm.startFromColor(Colors.green),
                      child: const Text("Iniciar Verde"),
                    ),
                    const SizedBox(width: 15),
                    OutlinedButton(
                      onPressed: () => vm.resetSelector(),
                      child: const Text("Resetear"),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
