import 'package:flutter/material.dart';

Locale createLocale(String language) => Locale(language);

void safeSetState(VoidCallback fn) => fn();