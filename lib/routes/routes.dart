import 'package:chatgpt/presentation/screens/home.dart';
import 'package:flutter/material.dart';

Map<String, WidgetBuilder> getRoutes = <String, WidgetBuilder>{
  HomeScreen.route: (context) => const HomeScreen()
};
