import 'package:flutter/material.dart';

extension DoubleEdgeInsetsExtesion on double {
  EdgeInsetsGeometry all() => EdgeInsets.all(this);

  EdgeInsetsGeometry left() => EdgeInsets.only(left: this);

  EdgeInsetsGeometry top() => EdgeInsets.only(top: this);

  EdgeInsetsGeometry right() => EdgeInsets.only(right: this);

  EdgeInsetsGeometry bottom() => EdgeInsets.only(bottom: this);

  EdgeInsetsGeometry none() => EdgeInsets.zero;

  EdgeInsetsGeometry horizontal() => EdgeInsets.only(left: this, right: this);

  EdgeInsetsGeometry vertical() => EdgeInsets.only(top: this, bottom: this);
}

extension IntEdgeInsetsExtesion on int {
  EdgeInsetsGeometry all() => EdgeInsets.all(toDouble());

  EdgeInsetsGeometry left() => EdgeInsets.only(left: toDouble());

  EdgeInsetsGeometry top() => EdgeInsets.only(top: toDouble());

  EdgeInsetsGeometry right() => EdgeInsets.only(right: toDouble());

  EdgeInsetsGeometry bottom() => EdgeInsets.only(bottom: toDouble());

  EdgeInsetsGeometry none() => EdgeInsets.zero;

  EdgeInsetsGeometry horizontal() =>
      EdgeInsets.only(left: toDouble(), right: toDouble());

  EdgeInsetsGeometry vertical() =>
      EdgeInsets.only(top: toDouble(), bottom: toDouble());
}
