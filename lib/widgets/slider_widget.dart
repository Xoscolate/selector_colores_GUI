import 'package:flutter/material.dart';

class SliderWidget  extends StatelessWidget {
  // Parámetros de estado que recibe desde la vista
  final double hue;
  final double saturation;
  final double lightness;
  final double alpha;

  // Callback obligatorio para avisar de los cambios [3]
  final Function(double h, double s, double l, double a) onHslChanged;

  const SliderWidget ({
    super.key,
    required this.hue,
    required this.saturation,
    required this.lightness,
    required this.alpha,
    required this.onHslChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Barra 1: Tono (Hue) de 0 a 360 grados
        _buildSlider("Hue (Tono)", hue, 0.0, 360.0,
                (val) => onHslChanged(val, saturation, lightness, alpha), Colors.orange),

        // Barra 2: Saturación (0 a 1)
        _buildSlider("Saturation", saturation, 0.0, 1.0,
                (val) => onHslChanged(hue, val, lightness, alpha), Colors.green),

        // Barra 3: Luminosidad (0 a 1)
        _buildSlider("Lightness", lightness, 0.0, 1.0,
                (val) => onHslChanged(hue, saturation, val, alpha), Colors.blue),

        // Barra 4: Transparencia / Alfa (0 a 1)
        _buildSlider("Alpha", alpha, 0.0, 1.0,
                (val) => onHslChanged(hue, saturation, lightness, val), Colors.grey),
      ],
    );
  }

  // Pequeña función auxiliar para no repetir código creando 4 barras
  Widget _buildSlider(String label, double value, double min, double max, Function(double) onChanged, Color activeColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
            "$label: ${value.toStringAsFixed(2)}",
            style: const TextStyle(fontWeight: FontWeight.bold)
        ),
        Slider(
          value: value.clamp(min, max), // clamp evita errores matemáticos
          min: min,
          max: max,
          activeColor: activeColor,
          onChanged: onChanged,
        ),
      ],
    );
  }
}