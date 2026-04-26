import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodels/selector_colores_viewmodel.dart';
import '../widgets/selector_colores_widget.dart';

/// Pantalla principal que muestra el Selector de Color y reacciona a los cambios.
class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. LECTURA DEL ESTADO: Nos suscribimos al ViewModel
    // Si el VM hace notifyListeners(), este build se vuelve a ejecutar.
    final vm = context.watch<ColorSelectorViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Práctica: Selector HSL'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Texto de Feedback leyendo datos en tiempo real
            Text(
              "Color seleccionado: ${vm.state.currentColor.toString()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),

            // 2. INSTANCIAMOS TU CUSTOM WIDGET
            ColorSelectorWidget(
              // Pasamos el modelo de estado obligatorio
              state: vm.state,

              // Parámetros de estilo
              size: 300,
              borderColor: Colors.blueGrey,

              // 3. ENLAZAMOS LOS CALLBACKS AL VIEWMODEL
              // a) onColorSelect exigido por el enunciado (adaptado con X e Y)
              onColorSelect: (Color nuevoColor, double x, double y) {
                // Ahora le pasamos las coordenadas reales (x, y) que nos
                // envía el Custom Widget al hacer clic o arrastrar.
                vm.selectColor(nuevoColor, x, y);
              },

              // b) onReset() exigido por el enunciado
              onReset: () {
                vm.resetSelector();
              },

              // c) onStartFrom(Color color) exigido por el enunciado
              onStartFrom: (Color colorInicial) {
                vm.startFromColor(colorInicial);
              },
            ),

            const SizedBox(height: 40),

            // Botones de prueba para forzar los callbacks manualmente
            // antes de programar los clics en el propio cuadrado.
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
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
    );
  }
}