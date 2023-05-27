import 'package:flutter/material.dart';

extension WidgetExtension on Widget {
  Padding margin(EdgeInsetsGeometry padding) {
    return Padding(
      padding: padding,
      child: this,
    );
  }

  Center center() {
    return Center(
      child: this,
    );
  }

  Align topCenter() {
    return Align(
      alignment: Alignment.topLeft,
      child: this,
    );
  }

  Align bottomCenter() {
    return Align(
      alignment: Alignment.topLeft,
      child: this,
    );
  }

  Align centerRight() {
    return Align(
      alignment: Alignment.centerRight,
      child: this,
    );
  }

  Align centerLeft() {
    return Align(
      alignment: Alignment.topLeft,
      child: this,
    );
  }

  Align topLeft() {
    return Align(
      alignment: Alignment.topLeft,
      child: this,
    );
  }

  Align topRight() {
    return Align(
      alignment: Alignment.topLeft,
      child: this,
    );
  }

  Align bottomLeft() {
    return Align(
      alignment: Alignment.topLeft,
      child: this,
    );
  }

  Align bottomRight() {
    return Align(
      alignment: Alignment.topLeft,
      child: this,
    );
  }

  Expanded expanded() {
    return Expanded(child: this);
  }

  SizedBox size(double width, double height) {
    return SizedBox(
      width: width,
      height: height,
      child: this,
    );
  }
}
