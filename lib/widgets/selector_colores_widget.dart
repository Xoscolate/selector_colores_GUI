import 'package:flutter/material.dart';
import '../models/selector_colores_estado.dart';

/// Custom Widget que permite seleccionar un color HSL interactuando con un puntero.
class ColorSelectorWidget extends StatelessWidget {

  /// 1. Objeto de Estado inmutable obligatorio (RA 3.3).
  final ColorSelectorState state;

  /// 2. Parámetro de estilo opcional: Tamaño del cuadrado del selector.
  final double size;

  /// 2. Parámetro de estilo opcional: Color de la vora del selector.
  final Color borderColor;

  /// 3. Callback que se dispara cuando el usuario selecciona un nuevo color.
  final Function(Color) onColorSelect;

  /// 3. Callback que reinicia el estado del widget a los valores por defecto.
  final VoidCallback onReset;

  /// 3. Callback que inicia el selector partiendo de un color concreto.
  final Function(Color) onStartFrom;

  /// Constructor principal del Custom Widget.
  const ColorSelectorWidget({
    super.key,
    required this.state,
    this.size = 300.0,
    this.borderColor = Colors.black,
    required this.onColorSelect,
    required this.onReset,
    required this.onStartFrom,
  });

  @override
  Widget build(BuildContext context) {
    // GestureDetector nos permitirá detectar clics y arrastres del ratón/dit.
    return GestureDetector(
      // onTapDown detecta el momento exacto en el que el usuario hace clic.
      onTapDown: (TapDownDetails details) {
        // Aquí en el futuro capturaremos las coordenadas para enviarlas por callback.
      },
      // Container delimita el tamaño total basado en el parámetro de estilo.
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          border: Border.all(color: borderColor, width: 2),
        ),
        // Stack nos permite apilar el fondo y el puntero en coordenadas locales.
        child: Stack(
          fit: StackFit.expand,
          children: [
            // CAPA 1: El fondo. Temporalmente pondremos el color del estado.
            // Más adelante aquí irá un gradiente HSL complejo.
            Container(color: state.currentColor),

            // CAPA 2: El marcador/puntero.
            Positioned(
              // Restamos la mitad del tamaño del marcador (10) para centrarlo en la coordenada
              left: state.posX - 10,
              top: state.posY - 10,
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle, // Dibuja un círculo perfecto
                  border: Border.all(color: Colors.black, width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha:0.5),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}