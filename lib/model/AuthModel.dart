/* 
{
    "token": "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJqdWFuLnBlcmV6QGhvc3BpdGFsLmNvbSIsImlhdCI6MTczMTY1MjExNywiZXhwIjoxNzMxNzM4NTE3fQ.Kx3bCy1gl6Bz6T3zPuU3Df-eF5qpCnG8W83qaEYopi4",
    "email": "juan.perez@hospital.com",
    "role": {
        "id": 1,
        "nombre": "ADMIN"
    },
    "nombre": "Juan",
    "apellido": "Pérez",
    "id": 1
}
 */
class AuthModel {
  String? token;
  String? email;
  Role? role;
  String? nombre;
  String? apellido;
  int? id;

  AuthModel({this.token, this.email, this.role, this.nombre, this.apellido, this.id});

  AuthModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    email = json['email'];
    role = json['role'] != null ? new Role.fromJson(json['role']) : null;
    nombre = json['nombre'];
    apellido = json['apellido'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['email'] = this.email;
    if (this.role != null) {
      data['role'] = this.role!.toJson();
    }
    data['nombre'] = this.nombre;
    data['apellido'] = this.apellido;
    data['id'] = this.id;
    return data;
  }

  @override
  String toString() {
    return 'Authmodel{token: $token, email: $email, role: $role, nombre: $nombre, apellido: $apellido, id: $id}';
  }
}

class Role {
  int? id;
  String? nombre;

  Role({this.id, this.nombre});

  Role.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nombre = json['nombre'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nombre'] = this.nombre;
    return data;
  }

  @override
  String toString() {
    return 'Role{id: $id, nombre: $nombre}';
  }
}