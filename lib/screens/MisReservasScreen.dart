import 'package:flutter/material.dart';
import 'package:fichas_med_app/model/ReservaModel.dart';
import 'package:fichas_med_app/services/reserva_service.dart';
import 'package:nb_utils/nb_utils.dart'; // Para estilos y tamaños

class MisReservasScreen extends StatefulWidget {
  const MisReservasScreen({Key? key}) : super(key: key);

  @override
  _MisReservasScreenState createState() => _MisReservasScreenState();
}

class _MisReservasScreenState extends State<MisReservasScreen> {
  late Future<List<ReservaModel>> _reservasFuture;

  @override
  void initState() {
    super.initState();
    _reservasFuture = ReservaService().getAllReservasByPacienteId();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Reservas'),
        centerTitle: true, // Centra el título en el AppBar
        elevation: 0, // Sin sombra
        // backgroundColor: Theme.of(context).appBarTheme.color,
        iconTheme: Theme.of(context).appBarTheme.iconTheme,
        titleTextStyle: Theme.of(context).appBarTheme.titleTextStyle,
        systemOverlayStyle: Theme.of(context).appBarTheme.systemOverlayStyle,
      ),
      body: FutureBuilder<List<ReservaModel>>(
        future: _reservasFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error al cargar reservas: ${snapshot.error}',
                style: boldTextStyle(color: Colors.red, size: 16),
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                'No tienes reservas registradas.',
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            );
          }

          final reservas = snapshot.data!;

          return ListView.builder(
            itemCount: reservas.length,
            padding: const EdgeInsets.all(12),
            itemBuilder: (context, index) {
              final reserva = reservas[index];
              final horario = reserva.horario;

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
                      // Estado de la reserva
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Estado: ${reserva.estado}',
                            style: boldTextStyle(
                                color: Colors.blueAccent, size: 16),
                          ),
                          Text(
                            'Ficha #: ${reserva.nroFicha}',
                            style: secondaryTextStyle(size: 14),
                          ),
                        ],
                      ),
                      const Divider(height: 16, thickness: 1),
                      // Fecha de reserva
                      Row(
                        children: [
                          const Icon(Icons.calendar_today,
                              size: 16, color: Colors.grey),
                          8.width,
                          Text(
                            'Fecha de reserva: ${reserva.fechaRegistroReserva}',
                            style: secondaryTextStyle(size: 14),
                          ),
                        ],
                      ),
                      8.height,
                      // Horario de atención (inicio y fin)
                      Row(
                        children: [
                          const Icon(Icons.access_time,
                              size: 16, color: Colors.grey),
                          8.width,
                          Text(
                            'Atención: ${reserva.horarioInicioAtencion ?? 'No asignado'} - ${reserva.horarioFinAtencion ?? 'No asignado'}',
                            style: secondaryTextStyle(size: 14),
                          ),
                        ],
                      ),
                      if (horario != null) ...[
                        8.height,
                        // Información del horario programado
                        Row(
                          children: [
                            const Icon(Icons.schedule,
                                size: 16, color: Colors.grey),
                            8.width,
                            Text(
                              'Día: ${horario.dia}',
                              style: secondaryTextStyle(size: 14),
                            ),
                          ],
                        ),
                        8.height,
                        Row(
                          children: [
                            const Icon(Icons.calendar_month,
                                size: 16, color: Colors.grey),
                            8.width,
                            Text(
                              'Fecha programada: ${horario.fecha}',
                              style: secondaryTextStyle(size: 14),
                            ),
                          ],
                        ),
                      ],
                      if (horario?.doctor != null) ...[
                        16.height,
                        // Información del doctor
                        Row(
                          children: [
                            const Icon(Icons.person,
                                size: 16, color: Colors.grey),
                            8.width,
                            Text(
                              'Doctor: ${horario!.doctor!.persona!.nombre} ${horario.doctor!.persona!.apellido}',
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
                              'Especialidad: ${horario.doctor!.especialidad!.nombre}',
                              style: secondaryTextStyle(size: 14),
                            ),
                          ],
                        ),
                      ],
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
