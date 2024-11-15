import 'package:fichas_med_app/model/AuthorityModel.dart';
import 'package:fichas_med_app/model/RolModel.dart';

class UsuarioModel {
  int? id;
  String? email;
  String? password;
  bool? activo;
  bool? cuentaNoExpirada;
  bool? cuentaNoBloqueada;
  bool? credencialesNoExpiradas;
  List<RolModel>? roles;
  bool? enabled;
  String? username;
  List<AuthorityModel>? authorities;
  bool? accountNonExpired;
  bool? credentialsNonExpired;
  bool? accountNonLocked;

  UsuarioModel(
      {this.id,
      this.email,
      this.password,
      this.activo,
      this.cuentaNoExpirada,
      this.cuentaNoBloqueada,
      this.credencialesNoExpiradas,
      this.roles,
      this.enabled,
      this.username,
      this.authorities,
      this.accountNonExpired,
      this.credentialsNonExpired,
      this.accountNonLocked});

  UsuarioModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    password = json['password'];
    activo = json['activo'];
    cuentaNoExpirada = json['cuentaNoExpirada'];
    cuentaNoBloqueada = json['cuentaNoBloqueada'];
    credencialesNoExpiradas = json['credencialesNoExpiradas'];
    if (json['roles'] != null) {
      roles = <RolModel>[];
      json['roles'].forEach((v) {
        roles!.add(RolModel.fromJson(v));
      });
    }
    enabled = json['enabled'];
    username = json['username'];
    if (json['authorities'] != null) {
      authorities = <AuthorityModel>[];
      json['authorities'].forEach((v) {
        authorities!.add(AuthorityModel.fromJson(v));
      });
    }
    accountNonExpired = json['accountNonExpired'];
    credentialsNonExpired = json['credentialsNonExpired'];
    accountNonLocked = json['accountNonLocked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['password'] = password;
    data['activo'] = activo;
    data['cuentaNoExpirada'] = cuentaNoExpirada;
    data['cuentaNoBloqueada'] = cuentaNoBloqueada;
    data['credencialesNoExpiradas'] = credencialesNoExpiradas;
    if (roles != null) {
      data['roles'] = roles!.map((v) => v.toJson()).toList();
    }
    data['enabled'] = enabled;
    data['username'] = username;
    if (authorities != null) {
      data['authorities'] = authorities!.map((v) => v.toJson()).toList();
    }
    data['accountNonExpired'] = accountNonExpired;
    data['credentialsNonExpired'] = credentialsNonExpired;
    data['accountNonLocked'] = accountNonLocked;
    return data;
  }
}
