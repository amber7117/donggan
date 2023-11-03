import 'package:flutter/material.dart';

extension Style on Widget {
  padding(EdgeInsets inset) {
    return Padding(padding: inset, child: this);
  }

  decorate(BoxDecoration decoration) {
    return DecoratedBox(decoration: decoration, child: this);
  }

  clipRRect(double radius) {
    return ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(radius)), child: this);
  }

  colored(Color color) {
    return ColoredBox(color: color, child: this);
  }

  inkWell(VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: this,
    );
  }
}

