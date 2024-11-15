import 'package:fichas_med_app/services/reserva_service.dart';
import 'package:flutter/material.dart';
import 'package:fichas_med_app/model/EspecialidadModel.dart';
import 'package:fichas_med_app/model/HorarioModel.dart';
import 'package:fichas_med_app/services/horario_service.dart';
import 'package:nb_utils/nb_utils.dart';

class MLHorariosScreen extends StatefulWidget {
  final EspecialidadModel especialidad;

  const MLHorariosScreen({Key? key, required this.especialidad})
      : super(key: key);

  @override
  _MLHorariosScreenState createState() => _MLHorariosScreenState();
}

class _MLHorariosScreenState extends State<MLHorariosScreen> {
  late Future<List<HorarioModel>> _horariosFuture;
  final HorarioService _horarioService = HorarioService();
  final ReservaService _reservaService = ReservaService();

  @override
  void initState() {
    super.initState();
    _horariosFuture = _horarioService.getAllHorarios();
  }

  Future<void> _reservarCita(int horarioId) async {
    try {
      await _reservaService.createReserva(
        especialidadId: widget.especialidad.id!,
        horarioId: horarioId,
      );
      Navigator.pop(context);
      toast('Cita reservada con éxito');
    } catch (e) {
      toast('Error: $e', bgColor: Colors.red);
    }
  }

  void _showConfirmDialog(int horarioId) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Confirmación',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content:
              const Text('¿Estás seguro de que deseas reservar esta cita?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
              ),
              onPressed: () async {
                Navigator.pop(context);
                await _reservarCita(horarioId);
              },
              child: const Text('Confirmar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Horarios: ${widget.especialidad.nombre}',
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        elevation: 0,
        iconTheme: Theme.of(context).appBarTheme.iconTheme,
        titleTextStyle: Theme.of(context).appBarTheme.titleTextStyle,
        systemOverlayStyle: Theme.of(context).appBarTheme.systemOverlayStyle,
      ),
      body: FutureBuilder<List<HorarioModel>>(
        future: _horariosFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error al cargar los horarios: ${snapshot.error}',
                style: boldTextStyle(color: Colors.red, size: 16),
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                'No hay horarios disponibles.',
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            );
          }

          final horarios = snapshot.data!
              .where((horario) =>
                  horario.doctor?.especialidad?.id == widget.especialidad.id)
              .toList();

          if (horarios.isEmpty) {
            return const Center(
              child: Text(
                'No hay horarios para esta especialidad.',
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            );
          }

          return ListView.builder(
            itemCount: horarios.length,
            padding: const EdgeInsets.all(12),
            itemBuilder: (context, index) {
              final horario = horarios[index];
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
                      // Fecha y Día
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            horario.fecha ?? 'Sin fecha',
                            style: boldTextStyle(
                                color: Colors.blueAccent, size: 16),
                          ),
                          Text(
                            'Día: ${horario.dia ?? 'No especificado'}',
                            style: secondaryTextStyle(size: 14),
                          ),
                        ],
                      ),
                      const Divider(height: 16, thickness: 1),
                      // Horario de Atención
                      Row(
                        children: [
                          const Icon(Icons.access_time,
                              size: 16, color: Colors.grey),
                          8.width,
                          Text(
                            'Horario: ${horario.horaInicio ?? 'No asignado'} - ${horario.horaFin ?? 'No asignado'}',
                            style: secondaryTextStyle(size: 14),
                          ),
                        ],
                      ),
                      8.height,
                      // Información del Doctor
                      if (horario.doctor != null) ...[
                        Row(
                          children: [
                            const Icon(Icons.person,
                                size: 16, color: Colors.grey),
                            8.width,
                            Text(
                              'Doctor: ${horario.doctor!.persona?.nombre ?? 'No asignado'} ${horario.doctor!.persona?.apellido ?? ''}',
                              style: boldTextStyle(size: 14),
                            ),
                          ],
                        ),
                        8.height,
                        Row(
                          children: [
                            const Icon(Icons.local_hospital,
                                size: 16, color: Colors.grey),
                            8.width,
                            Text(
                              'Especialidad: ${horario.doctor!.especialidad?.nombre ?? 'No asignada'}',
                              style: secondaryTextStyle(size: 14),
                            ),
                          ],
                        ),
                      ],
                      // Botón de Reservar
                      Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () => _showConfirmDialog(horario.id!),
                          child: const Text(
                            'Reservar',
                            style: TextStyle(color: Colors.white),
                          ),
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
