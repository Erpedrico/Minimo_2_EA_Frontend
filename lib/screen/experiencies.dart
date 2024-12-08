/*import 'package:flutter/material.dart';
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
  bool _showForm = false;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _ownerController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _contactnumberController = TextEditingController();
  final TextEditingController _contactmailController = TextEditingController();
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
    // Convertir el texto de _priceController a un número entero
    int? price = int.tryParse(_priceController.text);
    int? contactnumber = int.tryParse(_contactnumberController.text);

    ExperienceModel newExperience = ExperienceModel(
      title: _titleController.text,
      description: _descriptionController.text,
      owner: _ownerController.text,
      price: price, // Usar el entero convertido
      location: _locationController.text,
      contactnumber: contactnumber,
      contactmail: _contactmailController.text,
    );

    int status = await _experienceService.createExperience(newExperience);
    if (status == 201) {
      // Limpiar los campos de entrada tras un éxito
      _titleController.clear();
      _descriptionController.clear();
      _ownerController.clear();
      _priceController.clear();
      _locationController.clear();
      _contactnumberController.clear();
      _contactmailController.clear();

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
                        title: Text(experience.title ?? 'Sin título'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Descripción: ${experience.description ?? 'Sin descripción'}'),
                            Text('Owner: ${experience.owner ?? 'Sin owner'}'),
                            Text('Precio: ${experience.price ?? 'Sin precio'}'),
                            Text('Localicación: ${experience.location ?? 'Sin localización'}'),
                            Text('Teléfono de contacto: ${experience.contactnumber ?? 'Sin numero de telefono'}'),
                            Text('Mail de contacto: ${experience.contactmail ?? 'Sin mail de contacto'}'),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                // Botón para mostrar u ocultar el formulario
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _showForm = !_showForm; // Cambia el estado
                    });
                  },
                  child: Text(_showForm ? 'Cerrar' : 'Crear experiencia'),
                ),

                if (_showForm)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        
                        TextField(
                          controller: _titleController,
                          decoration: InputDecoration(labelText: 'Titulo'),
                        ),

                        TextField(
                          controller: _descriptionController,
                          decoration: InputDecoration(labelText: 'Descripción'),
                        ),
      
                        TextField(
                          controller: _ownerController,
                          decoration: InputDecoration(labelText: 'Propietario'),
                        ),

                        TextField(
                          controller: _priceController,
                          decoration: InputDecoration(labelText: 'Precio'),
                        ),
                        
                        TextField(
                          controller: _locationController,
                          decoration: InputDecoration(labelText: 'Localización'),
                        ),

                        TextField(
                          controller: _contactnumberController,
                          decoration: InputDecoration(labelText: 'Numero de contacto'),
                        ),

                        TextField(
                          controller: _contactmailController,
                          decoration: InputDecoration(labelText: 'Mail de contacto'),
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
}*/

/*
import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/experienceService.dart';
import 'package:flutter_application_1/models/experienceModel.dart';
import 'package:flutter_application_1/Widgets/experienceCard.dart';

class ExperienciesPage extends StatefulWidget {
  @override
  _ExperienciesPageState createState() => _ExperienciesPageState();
}

class _ExperienciesPageState extends State<ExperienciesPage> {
  final ExperienceService _experienceService = ExperienceService();
  List<ExperienceModel> _experiences = [];
  bool _isLoading = true;
  bool _showForm = false;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _ownerController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _contactnumberController = TextEditingController();
  final TextEditingController _contactmailController = TextEditingController();

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
      int? price = int.tryParse(_priceController.text);
      int? contactnumber = int.tryParse(_contactnumberController.text);

      ExperienceModel newExperience = ExperienceModel(
        title: _titleController.text,
        description: _descriptionController.text,
        owner: _ownerController.text,
        price: price,
        location: _locationController.text,
        contactnumber: contactnumber,
        contactmail: _contactmailController.text,
      );

      int status = await _experienceService.createExperience(newExperience);
      if (status == 201) {
        _titleController.clear();
        _descriptionController.clear();
        _ownerController.clear();
        _priceController.clear();
        _locationController.clear();
        _contactnumberController.clear();
        _contactmailController.clear();
        _loadExperiences();
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
                      return Card(
                        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                experience.title ?? 'Sin título',
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 8),
                              Text('Descripción: ${experience.description ?? 'Sin descripción'}'),
                              const SizedBox(height: 8),
                              Text('Propietario: ${experience.owner ?? 'Sin propietario'}'),
                              const SizedBox(height: 8),
                              Text('Precio: \$${experience.price ?? 'N/A'}'),
                              const SizedBox(height: 8),
                              Text('Localización: ${experience.location ?? 'Sin localización'}'),
                              const SizedBox(height: 8),
                              Text('Teléfono: ${experience.contactnumber ?? 'Sin número'}'),
                              const SizedBox(height: 8),
                              Text('Correo: ${experience.contactmail ?? 'Sin correo'}'),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _showForm = !_showForm;
                    });
                  },
                  child: Text(_showForm ? 'Ocultar Formulario' : 'Mostrar Formulario'),
                ),
                if (_showForm)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        TextField(
                          controller: _titleController,
                          decoration: InputDecoration(labelText: 'Titulo'),
                        ),
                        TextField(
                          controller: _descriptionController,
                          decoration: InputDecoration(labelText: 'Descripción'),
                        ),
                        TextField(
                          controller: _ownerController,
                          decoration: InputDecoration(labelText: 'Propietario'),
                        ),
                        TextField(
                          controller: _priceController,
                          decoration: InputDecoration(labelText: 'Precio'),
                        ),
                        TextField(
                          controller: _locationController,
                          decoration: InputDecoration(labelText: 'Localización'),
                        ),
                        TextField(
                          controller: _contactnumberController,
                          decoration: InputDecoration(labelText: 'Número de contacto'),
                        ),
                        TextField(
                          controller: _contactmailController,
                          decoration: InputDecoration(labelText: 'Correo de contacto'),
                        ),
                        const SizedBox(height: 10),
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
}*/

import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/experienceService.dart';
import 'package:flutter_application_1/models/experienceModel.dart';
import 'package:flutter_application_1/Widgets/experienceCard.dart';
import 'package:latlong2/latlong.dart';


class ExperienciesPage extends StatefulWidget {
  @override
  _ExperienciesPageState createState() => _ExperienciesPageState();
}

class _ExperienciesPageState extends State<ExperienciesPage> {
  final ExperienceService _experienceService = ExperienceService();
  List<ExperienceModel> _experiences = [];
  bool _isLoading = true;
  bool _showForm = false;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _ownerController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _contactnumberController = TextEditingController();
  final TextEditingController _contactmailController = TextEditingController();
  final TextEditingController _latitudeController = TextEditingController();
  final TextEditingController _longitudeController = TextEditingController();

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

  Future<void> _deleteExperience(String id) async {
    try {
      int status = await _experienceService.deleteExperienceById(id); // O reemplazar con `deleteExperience(id)` si está implementado
      if (status == 201) {
        setState(() {
          _experiences.removeWhere((experience) => experience.id == id);
        });
      } else {
        print('Error deleting experience');
      }
    } catch (e) {
      print('Error deleting experience: $e');
    }
  }

  Future<void> _createExperience() async {
  try {
    int? price = int.tryParse(_priceController.text);
    int? contactnumber = int.tryParse(_contactnumberController.text);
    double? latitude = double.tryParse(_latitudeController.text);  // Asegúrate de que sea un double
    double? longitude = double.tryParse(_longitudeController.text);

    ExperienceModel newExperience = ExperienceModel(
      title: _titleController.text,
      description: _descriptionController.text,
      owner: _ownerController.text,
      price: price,
      location: _locationController.text,
      contactnumber: contactnumber,
      contactmail: _contactmailController.text,
      coordinates: (latitude != null && longitude != null) ? LatLng(latitude, longitude) : null,
    );

    int status = await _experienceService.createExperience(newExperience);
    if (status == 201) {
      _titleController.clear();
      _descriptionController.clear();
      _ownerController.clear();
      _priceController.clear();
      _locationController.clear();
      _contactnumberController.clear();
      _contactmailController.clear();
      _latitudeController.clear();  // Limpiar el campo de latitud
      _longitudeController.clear();  // Limpiar el campo de longitud
      _loadExperiences();
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
                      return ExperienceCard(
                        experience: experience,
                        onDelete: () => _deleteExperience(experience.id!),
                      );
                    },
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _showForm = !_showForm;
                    });
                  },
                  child: Text(_showForm ? 'Ocultar Formulario' : 'Mostrar Formulario'),
                ),
                if (_showForm)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        TextField(
                          controller: _titleController,
                          decoration: InputDecoration(labelText: 'Titulo'),
                        ),
                        TextField(
                          controller: _descriptionController,
                          decoration: InputDecoration(labelText: 'Descripción'),
                        ),
                        TextField(
                          controller: _ownerController,
                          decoration: InputDecoration(labelText: 'Propietario'),
                        ),
                        TextField(
                          controller: _priceController,
                          decoration: InputDecoration(labelText: 'Precio'),
                        ),
                        TextField(
                          controller: _locationController,
                          decoration: InputDecoration(labelText: 'Localización'),
                        ),
                        TextField(
                          controller: _contactnumberController,
                          decoration: InputDecoration(labelText: 'Número de contacto'),
                        ),
                        TextField(
                          controller: _contactmailController,
                          decoration: InputDecoration(labelText: 'Correo de contacto'),
                        ),
                        TextField(
                          controller: _latitudeController,
                          decoration: InputDecoration(labelText: 'Latitud'),
                        ),
                         TextField(
                          controller: _longitudeController,
                          decoration: InputDecoration(labelText: 'Longitud'),
                        ),
                        
                        const SizedBox(height: 10),
                        
                        
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
