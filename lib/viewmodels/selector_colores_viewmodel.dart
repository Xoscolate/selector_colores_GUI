import 'package:flutter/material.dart';
import '../models/selector_colores_estado.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
/// ViewModel que actúa como cerebro para el Selector de Color HSL.
/// Hereda de ChangeNotifier para avisar a la interfaz cuando hay cambios.
class ColorSelectorViewModel extends ChangeNotifier {

  /// Instancia privada del modelo de estado actual.
  ColorSelectorState _state;

  /// Constructor que recibe el estado inicial para mantener el desacoplamiento.
  ColorSelectorViewModel(this._state);

  /// Getter público para que la vista pueda leer el estado actual.
  ColorSelectorState get state => _state;




  /// Método para seleccionar un color nuevo y actualizar la posición del puntero.
  /// Este método responderá al callback [onColorSelect] de tu widget.
  void selectColor(Color newColor, double x, double y) {
    // 1. Copiamos el estado actual y le cambiamos el color y las coordenadas
    _state = _state.copyWith(
      currentColor: newColor,
      posX: x,
      posY: y,
    );
    // 2. Avisamos a Flutter para que redibuje la pantalla
    notifyListeners();
  }


  /// Método para inicializar el selector partiendo de un color específico.
  /// Este método responderá al callback [onStartFrom].
  // Callback: c) onStartFrom(Color color)
  void startFromColor(Color nuevoColor) {
    // Si el color es verde, le damos sus coordenadas exactas (X: 100, Y: 150)
    // Puedes añadir más colores con un 'if' o 'switch' si añades más botones
    double nuevaX = 0.0;
    double nuevaY = 0.0;

    if (nuevoColor == Colors.green) {
      nuevaX = 100.0;
      nuevaY = 150.0;
    }

    _state = _state.copyWith(
      currentColor: nuevoColor,
      posX: nuevaX,
      posY: nuevaY,
    );
    notifyListeners(); // Avisamos a la pantalla para que redibuje [4]
  }

  // Callback: b) onReset()
  void resetSelector() {
    // El reset devuelve el color a blanco y esconde el marcador en 0,0
    _state = _state.copyWith(
      currentColor: Colors.white,
      posX: 0.0,
      posY: 0.0,
    );
    notifyListeners();
  }

  // --- VARIABLES DE SISTEMA ---
  String? _rutaCarpeta;

  // 1. FIRST RUN EXPERIENCE: Seleccionar carpeta con file_picker [1]
  Future<bool> instalarApp() async {
    // Abre la ventana del sistema operativo para elegir carpeta
    String? rutaSeleccionada = await FilePicker.platform.getDirectoryPath();

    if (rutaSeleccionada != null) {
      _rutaCarpeta = rutaSeleccionada;

      // Verificamos si ya existe un archivo de guardado
      final fitxer = File('$_rutaCarpeta/config.txt');
      if (fitxer.existsSync()) {
        restaurarConfiguracion(); // Si existe, lo leemos
      } else {
        guardarConfiguracion(); // Si no existe, creamos uno nuevo
      }
      return true; // Instalación exitosa
    }
    return false; // El usuario canceló la ventana
  }

  // 2. PERSISTENCIA (ESCRITURA): Guardar el estado en un txt [1]
  void guardarConfiguracion() {
    if (_rutaCarpeta == null) return;

    final fitxer = File('$_rutaCarpeta/config.txt');
    // Guardamos el valor numérico del color actual (un valor por línea)
    fitxer.writeAsStringSync('${_state.currentColor.value}\n');
  }

  // 3. PERSISTENCIA (LECTURA): Restaurar el estado al abrir
  void restaurarConfiguracion() {
    if (_rutaCarpeta == null) return;

    final fitxer = File('$_rutaCarpeta/config.txt');
    if (fitxer.existsSync()) {
      // Leemos el archivo línea por línea [1]
      List<String> linies = fitxer.readAsLinesSync();
      if (linies.isNotEmpty) {
        // ¡EL CAMBIO ESTÁ AQUÍ! Seleccionamos la primera línea (linies.first o linies)
        int colorValue = int.parse(linies.first);

        // Restauramos el estado con el color guardado
        _state = _state.copyWith(currentColor: Color(colorValue));
        notifyListeners();
      }
    }
  }
}