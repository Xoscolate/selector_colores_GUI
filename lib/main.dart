import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/selector_colores_estado.dart';
import 'viewmodels/selector_colores_viewmodel.dart';
import 'widgets/selector_colores_widget.dart';
import 'views/pantalla.dart';

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
        home: MiAppSelectorColor(),
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
        duration: const Duration(milliseconds: 300), // Transición suave
        color: vm.state.currentColor, // ¡Aquí aplicamos el color al fondo!

        child: Center(
          child: Container(
            // Le ponemos un fondito semi-transparente blanco a la columna
            // para que el texto y los bordes se sigan leyendo bien aunque
            // elijas un color muy oscuro (como el negro).
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.8),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min, // Para que la caja no ocupe toda la pantalla
              children: [
                // Texto de Feedback
                Text(
                  "Color seleccionado: ${vm.state.currentColor.toString()}",
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 30),

                // TU CUSTOM WIDGET
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

                // Botones de prueba
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton(
                      onPressed: () => vm.startFromColor(Colors.green),
                      child: const Text("Iniciar en Verde"),
                    ),
                    const SizedBox(width: 20),
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
