import 'package:flutter/material.dart';
import '../models/selector_colores_estado.dart';

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

  /// Método para reiniciar el componente a sus valores por defecto.
  /// Este método responderá al callback [onReset].
  void resetSelector() {
    _state = const ColorSelectorState(); // Volvemos a la "foto" por defecto
    notifyListeners();
  }

  /// Método para inicializar el selector partiendo de un color específico.
  /// Este método responderá al callback [onStartFrom].
  void startFromColor(Color startColor) {
    // Aquí solo cambiamos el color, las coordenadas podrían necesitar
    // un cálculo matemático inverso en el futuro.
    _state = _state.copyWith(currentColor: startColor);
    notifyListeners();
  }
}