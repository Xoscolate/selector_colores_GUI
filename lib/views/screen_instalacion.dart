import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/selector_colores_viewmodel.dart'; // Ajusta la ruta si es necesario
import 'pantalla.dart'; // Importamos tu pantalla principal
import 'pantalla.dart';

class SetupScreen extends StatelessWidget {
  const SetupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Aquí usamos read() en lugar de watch() porque solo vamos a pulsar un botón, no a escuchar cambios constantes
    final vm = context.read<ColorSelectorViewModel>();

    return Scaffold(
      body: Center(
        child: Container(
          width: 400,
          padding: const EdgeInsets.all(30),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10)],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.folder_special, size: 60, color: Colors.blue),
              const SizedBox(height: 20),
              const Text(
                "Instalación de la App",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                "Para empezar a usar el Selector HSL, elige una carpeta en tu ordenador donde guardar los archivos de configuración.",
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              ElevatedButton.icon(
                icon: const Icon(Icons.folder_open),
                label: const Text("Seleccionar Carpeta de Datos"),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                ),
                onPressed: () async {
                  // 1. Llamamos a la función del file_picker
                  bool exito = await vm.instalarApp();

                  // 2. Si el usuario eligió la carpeta correctamente, saltamos a la App
                  if (exito && context.mounted) {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => const MainScreen()),                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}