import 'package:ddd1/CounterWidget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main(){
  runApp((ProviderScope(child: Counter())));
}
