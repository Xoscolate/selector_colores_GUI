import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:selector_colores_oscarnunezpino_dam2/views/pantalla.dart';
import '../viewmodels/selector_colores_viewmodel.dart';
import '../widgets/slider_widget.dart';
import 'package:selector_colores_oscarnunezpino_dam2/main.dart';

class HslSlidersScreen extends StatelessWidget {
  const HslSlidersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Escuchamos los cambios del ViewModel [5]
    final vm = context.watch<ColorSelectorViewModel>();

    // Magia de Flutter: Extraemos el HSL directamente de tu color guardado
    // para que las barras sepan exactamente en qué posición deben empezar
    final hsl = HSLColor.fromColor(vm.state.currentColor);

    return Scaffold(
      appBar: AppBar(title: const Text('Selector RGB / HSL (Alternativo)')),

      // EL FONDO RECICLADO [6]
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        color: vm.state.currentColor,
        child: Center(
          child: Container(
            width: 400,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.85),
                borderRadius: BorderRadius.circular(15),
                boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 10, offset: Offset(0, 5))]
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // PREVISUALIZACIÓN DEL COLOR (Inspirado en tus imágenes)
                Container(
                  width: double.infinity,
                  height: 100,
                  decoration: BoxDecoration(
                      color: vm.state.currentColor,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black12, width: 2)
                  ),
                ),
                const SizedBox(height: 20),

                // EL NUEVO CUSTOM WIDGET
                SliderWidget(
                  hue: hsl.hue,
                  saturation: hsl.saturation,
                  lightness: hsl.lightness,
                  alpha: hsl.alpha,
                  onHslChanged: (h, s, l, a) {
                    vm.cambiarColorDesdeBarras(h, s, l, a); // Callback al ViewModel
                  },
                ),

                const SizedBox(height: 30),

                // EL BOTÓN PARA VOLVER A LA PRÁCTICA ORIGINAL
                OutlinedButton.icon(
                  icon: const Icon(Icons.crop_square),
                  label: const Text("Volver al Cuadrado HSL"),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => const MainScreen()),
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