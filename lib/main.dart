import 'package:app_lista_contatos/my_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  runApp(const MyApp());
  await dotenv.load(fileName: ".env");
}
