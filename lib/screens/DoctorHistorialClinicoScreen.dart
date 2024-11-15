import 'package:flutter/material.dart';
import 'package:fichas_med_app/model/HistorialClinicoModel.dart';
import 'package:fichas_med_app/model/PacienteModel.dart';
import 'package:fichas_med_app/model/TratamientoModel.dart';
import 'package:fichas_med_app/services/historial_service.dart';
import 'package:fichas_med_app/services/tratamiento_service.dart';
import 'package:fichas_med_app/screens/TratamientoDetalleScreen.dart';
import 'package:nb_utils/nb_utils.dart';

class DoctorHistorialClinicoScreen extends StatefulWidget {
  const DoctorHistorialClinicoScreen({Key? key}) : super(key: key);

  @override
  _DoctorHistorialClinicoScreenState createState() =>
      _DoctorHistorialClinicoScreenState();
}

class _DoctorHistorialClinicoScreenState
    extends State<DoctorHistorialClinicoScreen> {
  late Future<List<HistorialClinicoModel>> _historialesFuture;
  final HistorialService _historialService = HistorialService();
  final TratamientoService _tratamientoService = TratamientoService();

  @override
  void initState() {
    super.initState();
    loadHistoriales();
  }

  /// Carga los historiales desde el servicio
  void loadHistoriales() {
    setState(() {
      _historialesFuture = _historialService.getAllHistoriales();
    });
  }

  /// Muestra el diálogo para agregar un nuevo tratamiento
  Future<void> _showAddTreatmentDialog(int historialId) async {
    final _formKey = GlobalKey<FormState>();
    String titulo = '';
    String detalle = '';
    String receta = '';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Agregar Tratamiento'),
          content: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Título'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'El título es requerido';
                      }
                      return null;
                    },
                    onChanged: (value) => titulo = value,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Detalle'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'El detalle es requerido';
                      }
                      return null;
                    },
                    onChanged: (value) => detalle = value,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Receta'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'La receta es requerida';
                      }
                      return null;
                    },
                    onChanged: (value) => receta = value,
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  Navigator.pop(context);
                  await _createTreatment(
                    historialId: historialId,
                    titulo: titulo,
                    detalle: detalle,
                    receta: receta,
                  );
                }
              },
              child: const Text('Guardar'),
            ),
          ],
        );
      },
    );
  }

  /// Llama al servicio para crear un tratamiento
  Future<void> _createTreatment({
    required int historialId,
    required String titulo,
    required String detalle,
    required String receta,
  }) async {
    try {
      await _tratamientoService.postTratamiento(
        titulo: titulo,
        detalle: detalle,
        receta: receta,
        historiaClinica_id: historialId,
      );
      toast('Tratamiento creado con éxito');
      loadHistoriales();
    } catch (e) {
      toast('Error al crear tratamiento: $e', bgColor: Colors.red);
    }
  }

  /// Navega a la pantalla de detalles del tratamiento
  void _navigateToTreatmentDetails(
      BuildContext context, TratamientoModel tratamiento) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            TratamientoDetalleScreen(tratamiento: tratamiento),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Historias Clínicas'),
        centerTitle: true,
        elevation: 0,
        iconTheme: Theme.of(context).appBarTheme.iconTheme,
        titleTextStyle: Theme.of(context).appBarTheme.titleTextStyle,
        systemOverlayStyle: Theme.of(context).appBarTheme.systemOverlayStyle,
      ),
      body: FutureBuilder<List<HistorialClinicoModel>>(
        future: _historialesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error al cargar las historias clínicas: ${snapshot.error}',
                style: boldTextStyle(color: Colors.red, size: 16),
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                'No hay historias clínicas registradas.',
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            );
          }

          final historiales = snapshot.data!;

          return ListView.builder(
            itemCount: historiales.length,
            padding: const EdgeInsets.all(12),
            itemBuilder: (context, index) {
              final historial = historiales[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8),
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            historial.titulo ?? 'Sin título',
                            style: boldTextStyle(
                                color: Colors.blueAccent, size: 16),
                          ),
                          Text(
                            'Creado: ${historial.fechaCreacion?.split("T").first ?? 'Desconocida'}',
                            style: secondaryTextStyle(size: 14),
                          ),
                        ],
                      ),
                      8.height,
                      Text(
                        'Descripción: ${historial.descripcion ?? 'No especificada'}',
                        style: secondaryTextStyle(size: 14),
                      ),
                      8.height,
                      Text(
                        'Tipo: ${historial.tipoHistoria ?? 'No especificado'}',
                        style: secondaryTextStyle(size: 14),
                      ),
                      if (historial.paciente != null) ...[
                        8.height,
                        Text(
                          'Paciente: ${historial.paciente?.persona?.nombre ?? ''} ${historial.paciente?.persona?.apellido ?? ''}',
                          style: boldTextStyle(size: 14),
                        ),
                        8.height,
                        Text(
                          'Nro. Seguro: ${historial.paciente?.nroSeguro ?? 'No asignado'}',
                          style: secondaryTextStyle(size: 14),
                        ),
                      ],
                      16.height,
                      if (historial.tratamientos != null &&
                          historial.tratamientos!.isNotEmpty)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: historial.tratamientos!
                              .map(
                                (tratamiento) => Padding(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        tratamiento.titulo ?? 'Sin título',
                                        style: secondaryTextStyle(size: 14),
                                      ),
                                      TextButton(
                                        onPressed: () =>
                                            _navigateToTreatmentDetails(
                                                context, tratamiento),
                                        child: const Text('Ver Detalles'),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                              .toList(),
                        )
                      else
                        const Text(
                          'No hay tratamientos registrados.',
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                          onPressed: () =>
                              _showAddTreatmentDialog(historial.id!),
                          child: const Text('Agregar Tratamiento'),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
