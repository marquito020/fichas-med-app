import 'package:fichas_med_app/screens/MLLoginScreen.dart';
import 'package:flutter/material.dart';
import 'package:fichas_med_app/sharePreferences/userPreferences.dart';

class ProfileScreen extends StatelessWidget {
  final UserPreferences prefs = UserPreferences();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi Perfil'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Avatar del usuario
            CircleAvatar(
              radius: 50,
              backgroundImage: const NetworkImage(
                  'https://www.cartoonize.net/wp-content/uploads/2024/05/avatar-maker-photo-to-cartoon.png'), // URL del avatar
              backgroundColor: Colors.grey[300],
            ),
            const SizedBox(height: 16),
            // Nombre del usuario
            Text(
              prefs.nombre.isNotEmpty ? prefs.nombre : 'Usuario',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            const SizedBox(height: 8),
            // Rol del usuario
            Text(
              prefs.role.isNotEmpty
                  ? '${prefs.role[0].toUpperCase()}${prefs.role.substring(1)}'
                  : 'Sin rol asignado',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 20),
            // Información adicional
            Card(
              margin: const EdgeInsets.symmetric(vertical: 10),
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      leading: const Icon(Icons.email, color: Colors.blueAccent),
                      title: const Text('Correo electrónico'),
                      subtitle: Text(
                        prefs.email.isNotEmpty ? prefs.email : 'No especificado',
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.account_circle, color: Colors.blueAccent),
                      title: const Text('ID de Usuario'),
                      subtitle: Text(
                        prefs.id.toString(),
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            // Botón de Cerrar Sesión
            ElevatedButton.icon(
              onPressed: () => _logout(context),
              icon: const Icon(Icons.logout),
              label: const Text('Cerrar sesión'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _logout(BuildContext context) {
    prefs.clearUser(); // Limpia las preferencias del usuario
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => MLLoginScreen(),
      ),
      (Route<dynamic> route) => false,
    );
  }
}
