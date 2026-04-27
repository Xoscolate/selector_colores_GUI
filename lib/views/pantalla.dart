import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodels/selector_colores_viewmodel.dart';
import '../widgets/selector_colores_widget.dart';
import 'pantalla2.dart'; // IMPORTANTE: Importamos la pantalla de las barras

/// Pantalla principal que muestra el Selector de Color y reacciona a los cambios.
class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // LECTURA DEL ESTADO: Nos suscribimos al ViewModel
    final vm = context.watch<ColorSelectorViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Práctica: Selector HSL'),
      ),
      // ANIMATED CONTAINER: El fondo reacciona al color seleccionado
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        color: vm.state.currentColor,
        child: Center(
          child: Container(
            width: 400,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.85),
                borderRadius: BorderRadius.circular(15),
                boxShadow: const [
                  BoxShadow(color: Colors.black26, blurRadius: 10, offset: Offset(0, 5))
                ]
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min, // Se ajusta al contenido
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Color seleccionado: ${vm.state.currentColor.toString()}",
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 30),

                // INSTANCIAMOS TU CUSTOM WIDGET (El Cuadrado)
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

                // Botones de control del cuadrado
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
                ),
                const SizedBox(height: 20),

                // --- BOTÓN CORREGIDO ---
                // Ahora navega a la PANTALLA de las barras, no al Widget directamente
                ElevatedButton.icon(
                  icon: const Icon(Icons.linear_scale),
                  label: const Text("Cambiar a vista de Barras HSL"),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black87,
                      foregroundColor: Colors.white
                  ),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => const HslSlidersScreen()),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}