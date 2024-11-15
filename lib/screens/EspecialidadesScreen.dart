import 'package:flutter/material.dart';
import 'package:fichas_med_app/model/EspecialidadModel.dart';
import 'package:fichas_med_app/services/especialidad_service.dart';

class EspecialidadesScreen extends StatefulWidget {
  const EspecialidadesScreen({Key? key}) : super(key: key);

  @override
  _EspecialidadesScreenState createState() => _EspecialidadesScreenState();
}

class _EspecialidadesScreenState extends State<EspecialidadesScreen> {
  late Future<List<EspecialidadModel>> _especialidadesFuture;

  @override
  void initState() {
    super.initState();
    _especialidadesFuture = EspecialidadService().getAllEspecialidades();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Especialidades'),
      ),
      body: FutureBuilder<List<EspecialidadModel>>(
        future: _especialidadesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error al cargar las especialidades: ${snapshot.error}',
                style: const TextStyle(color: Colors.red, fontSize: 16),
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                'No hay especialidades disponibles.',
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            );
          }

          final especialidades = snapshot.data!;

          return ListView.builder(
            itemCount: especialidades.length,
            padding: const EdgeInsets.all(12),
            itemBuilder: (context, index) {
              final especialidad = especialidades[index];
              return Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  leading: Icon(
                    Icons.local_hospital_outlined,
                    color: Theme.of(context).primaryColor,
                    size: 30,
                  ),
                  title: Text(
                    especialidad.nombre ?? 'Sin nombre',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  subtitle: Text(
                    especialidad.descripcion ?? 'Sin descripción',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  trailing: Icon(
                    especialidad.activo == true
                        ? Icons.check_circle
                        : Icons.cancel,
                    color:
                        especialidad.activo == true ? Colors.green : Colors.red,
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/horarios',
                        arguments: especialidad);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
