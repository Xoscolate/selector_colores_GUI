import 'package:flutter/material.dart';
import '../models/selector_colores_estado.dart';

/// Custom Widget que permite seleccionar un color HSL interactuando con un puntero.
class ColorSelectorWidget extends StatelessWidget {
  /// Objeto de Estado inmutable obligatorio.
  final ColorSelectorState state;

  /// Tamaño del cuadrado del selector.
  final double size;

  /// Color del borde del selector.
  final Color borderColor;

  /// Callback que se dispara cuando el usuario selecciona un nuevo color.
  /// Modificado para incluir X e Y y permitir redibujar el marcador.
  final Function(Color, double, double) onColorSelect;

  /// Callback que reinicia el widget.
  final VoidCallback onReset;

  /// Callback que inicia el selector partiendo de un color.
  final Function(Color) onStartFrom;

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

    // Función auxiliar para calcular coordenadas y el color HSL real
    void manejarInteraccion(Offset posicionGlobal) {
      // 1. Traducimos la coordenada Global a Local
      final RenderBox box = context.findRenderObject() as RenderBox;
      final Offset posicionLocal = box.globalToLocal(posicionGlobal);

      // 2. Extraemos X e Y asegurando que no se salgan del marco (clamp)
      double x = posicionLocal.dx.clamp(0.0, size);
      double y = posicionLocal.dy.clamp(0.0, size);

      // 3. MATEMÁTICAS HSL: Traducir píxeles a valores de color
      // Eje X = Hue (0 a 360)
      double hue = (x / size) * 360.0;
      // Eje Y = Lightness (1.0 blanco arriba, 0.0 negro abajo)
      double lightness = 1.0 - (y / size);
      // La saturación la dejamos fija al 100% (1.0) para este selector 2D
      double saturation = 1.0;

      // 4. Creamos el color matemático y avisamos al ViewModel
      Color colorCalculado = HSLColor.fromAHSL(1.0, hue, saturation, lightness).toColor();
      onColorSelect(colorCalculado, x, y);
    }

    return GestureDetector(
      onTapDown: (details) => manejarInteraccion(details.globalPosition),
      onPanUpdate: (details) => manejarInteraccion(details.globalPosition),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          border: Border.all(color: borderColor, width: 2),
          // Sombra opcional para dar sensación de profundidad
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 8,
              offset: Offset(2, 4),
            ),
          ],
        ),
        // STACK: Capas superpuestas
        child: Stack(
          fit: StackFit.expand,
          children: [
            // CAPA 1: Eje X (Hue) - Degradado Arcoíris Horizontal
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.red,
                    Colors.yellow,
                    Colors.green,
                    Colors.cyan,
                    Colors.blue,
                    Colors.purple,
                    Colors.red,
                  ],
                ),
              ),
            ),

            // CAPA 2: Eje Y (Lightness) - Degradado Vertical (Blanco a Negro)
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white,
                    Colors.transparent,
                    Colors.black,
                  ],
                ),
              ),
            ),

            // CAPA 3: EL MARCADOR (Puntero del usuario)
            if (state.posX > 0 || state.posY > 0)
              Positioned(
                left: state.posX - 10,
                top: state.posY - 10,
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: state.currentColor, // Pintamos el centro del puntero con el color actual
                    shape: BoxShape.circle, // Forma circular perfecta
                    border: Border.all(color: Colors.white, width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.5),
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