import 'package:flutter/material.dart';
import 'package:flutter_application_1/Widgets/experienceCard.dart'; // Suponiendo que existe
import 'package:flutter_application_1/services/experienceService.dart';
import 'package:flutter_application_1/models/experienceModel.dart';

class ExperienciesPage extends StatefulWidget {
  @override
  _ExperienciesPageState createState() => _ExperienciesPageState();
}

class _ExperienciesPageState extends State<ExperienciesPage> {
  final ExperienceService _experienceService = ExperienceService();
  List<ExperienceModel> _experiences = [];
  bool _isLoading = true;
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _tipoController = TextEditingController();
  final TextEditingController _ownerController = TextEditingController();
  //final TextEditingController _participantsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadExperiences();
  }

  Future<void> _loadExperiences() async {
    try {
      setState(() {
        _isLoading = true;
      });
      List<ExperienceModel> experiences = await _experienceService.getExperiences();
      setState(() {
        _experiences = experiences;
        _isLoading = false;
      });
    } catch (e) {
      print('Error loading experiences: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _createExperience() async {
    try {
      // Parse participants into a list from the text input
      /*List<String> participants = _participantsController.text
          .split(',')
          .map((participant) => participant.trim())
          .toList();*/

      ExperienceModel newExperience = ExperienceModel(
        description: _descriptionController.text,
        tipo: _tipoController.text,
        owner: _ownerController.text,
        //participants: participants,
        habilitado: true,
      );

      int status = await _experienceService.createExperience(newExperience);
      if (status == 201) {
        // Clear all input fields on success
        _descriptionController.clear();
        _tipoController.clear();
        _ownerController.clear();
        //_participantsController.clear();
        _loadExperiences(); // Recargar las experiencias
      } else {
        print('Error creating experience');
      }
    } catch (e) {
      print('Error creating experience: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Gestión de Experiencias')),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: _experiences.length,
                    itemBuilder: (context, index) {
                      final experience = _experiences[index];
                      return ListTile(
                        title: Text(experience.description ?? 'Sin descripción'),
                        subtitle: Text('Owner: ${experience.owner}'),
                      );
                    },
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [

                      TextField(
                        controller: _descriptionController,
                        decoration: InputDecoration(labelText: 'Descripción'),
                      ),
    
                      TextField(
                        controller: _ownerController,
                        decoration: InputDecoration(labelText: 'Propietario'),
                      ),

                      /*TextField(
                        controller: _participantsController,
                        decoration: InputDecoration(
                          labelText: 'Participantes (separados por comas)',
                        ),
                      ),*/
                      
                      SizedBox(height: 10),

                      ElevatedButton(
                        onPressed: _createExperience,
                        child: Text('Crear Experiencia'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
