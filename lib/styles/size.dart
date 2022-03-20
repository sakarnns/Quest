import 'package:flutter/material.dart';

height({required BuildContext context}) {
  return MediaQuery.of(context).size.height;
}

width({required BuildContext context}) {
  return MediaQuery.of(context).size.width;
}
