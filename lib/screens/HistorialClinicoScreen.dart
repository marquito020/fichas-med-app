import 'package:fichas_med_app/screens/TratamientoDetallePacienteScreen.dart';
import 'package:flutter/material.dart';
import 'package:fichas_med_app/model/HistorialClinicoModel.dart';
import 'package:fichas_med_app/model/TratamientoModel.dart';
import 'package:fichas_med_app/screens/TratamientoDetalleScreen.dart';
import 'package:fichas_med_app/services/historial_service.dart';
import 'package:nb_utils/nb_utils.dart';

class HistorialClinicoScreen extends StatefulWidget {
  const HistorialClinicoScreen({Key? key}) : super(key: key);

  @override
  _HistorialClinicoScreenState createState() => _HistorialClinicoScreenState();
}

class _HistorialClinicoScreenState extends State<HistorialClinicoScreen> {
  late Future<List<HistorialClinicoModel>> _historialesFuture;
  final HistorialService _historialService = HistorialService();

  @override
  void initState() {
    super.initState();
    _historialesFuture = _historialService.getAllMyHistoriales();
  }

  /// Navega a la pantalla de detalles del tratamiento
  void _navigateToTreatmentDetails(
      BuildContext context, TratamientoModel tratamiento) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            TratamientoDetallePacienteScreen(tratamiento: tratamiento),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Historiales Clínicos'),
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
                'Error al cargar los historiales: ${snapshot.error}',
                style: boldTextStyle(color: Colors.red, size: 16),
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                'No tienes historiales clínicos registrados.',
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
                      const Divider(height: 16, thickness: 1),
                      Row(
                        children: [
                          const Icon(Icons.category,
                              size: 16, color: Colors.grey),
                          8.width,
                          Text(
                            'Tipo: ${historial.tipoHistoria ?? 'No especificado'}',
                            style: secondaryTextStyle(size: 14),
                          ),
                        ],
                      ),
                      8.height,
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.description,
                              size: 16, color: Colors.grey),
                          8.width,
                          Expanded(
                            child: Text(
                              historial.descripcion ?? 'Sin descripción',
                              style: secondaryTextStyle(size: 14),
                            ),
                          ),
                        ],
                      ),
                      if (historial.tratamientos != null &&
                          historial.tratamientos!.isNotEmpty)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            16.height,
                            const Divider(height: 16, thickness: 1),
                            const Text(
                              'Tratamientos:',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            ...historial.tratamientos!.map(
                              (tratamiento) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4),
                                child: Row(
                                  children: [
                                    const Icon(Icons.local_pharmacy,
                                        size: 16, color: Colors.grey),
                                    8.width,
                                    Expanded(
                                      child: Text(
                                        tratamiento.titulo ?? 'Sin título',
                                        style: secondaryTextStyle(size: 14),
                                      ),
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
                            ),
                          ],
                        )
                      else
                        Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: Row(
                            children: [
                              const Icon(Icons.info_outline,
                                  size: 16, color: Colors.grey),
                              8.width,
                              Text(
                                'No hay tratamientos registrados.',
                                style: secondaryTextStyle(
                                    size: 14, color: Colors.grey),
                              ),
                            ],
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
