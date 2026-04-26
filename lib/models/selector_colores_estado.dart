import 'package:flutter/material.dart';

class ColorSelectorState {
  final double posX; //posicion x del puntero

  final double posY; //posicion y del puntero

  final Color currentColor; //color actual

  const ColorSelectorState({
    this.posX = 0.0,
    this.posY = 0.0,
    this.currentColor = Colors.red, // color inicial
  });


  ColorSelectorState copyWith({
    double? posX,
    double? posY,
    Color? currentColor,
  }) {
    return ColorSelectorState(
      posX: posX ?? this.posX,
      posY: posY ?? this.posY,
      currentColor: currentColor ?? this.currentColor,
    );
  }
}