import 'package:flutter/material.dart';
import 'package:flutter_application_1/Widgets/experienceCard.dart';
import 'package:get/get.dart';

class ExperienciesPage extends StatefulWidget {
  @override
  _ExperienciesPageState createState() => _ExperienciesPageState();
}

class _ExperienciesPageState extends State<ExperienciesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Gestión de Experiencias')),
    );
  }
}