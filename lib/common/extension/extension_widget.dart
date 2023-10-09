import 'package:flutter/material.dart';

extension Style on Widget {
  padding(EdgeInsets inset) {
    return Padding(padding: inset, child: this);
  }

  decorate(BoxDecoration decoration) {
    return DecoratedBox(decoration: decoration, child: this);
  }
}
