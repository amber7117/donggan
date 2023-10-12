import 'package:flutter/material.dart';

extension Style on Widget {
  padding(EdgeInsets inset) {
    return Padding(padding: inset, child: this);
  }

  decorate(BoxDecoration decoration) {
    return DecoratedBox(decoration: decoration, child: this);
  }

  colored(Color color) {
    return ColoredBox(
        color: color,
        child: const SizedBox(width: double.infinity, height: 0.5));
  }

  inkWell(VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: this,
    );
  }
}
