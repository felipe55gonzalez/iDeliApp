class UserDataDb {
  List<Data> data;

  UserDataDb({this.data});

  UserDataDb.fromJson(Map<String, dynamic> json) {
    if (json['Data'] != null) {
      data = new List<Data>();
      json['Data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['Data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String idUser;
  String uid;
  String nombre;
  String email;
  String telefono;
  String urlImagen;

  Data(Data data, 
      {this.idUser,
      this.uid,
      this.nombre,
      this.email,
      this.telefono,
      this.urlImagen});

  Data.fromJson(Map<String, dynamic> json) {
    idUser = json['IdUser'];
    uid = json['Uid'];
    nombre = json['Nombre'];
    email = json['email'];
    telefono = json['Telefono'];
    urlImagen = json['UrlImagen'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['IdUser'] = this.idUser;
    data['Uid'] = this.uid;
    data['Nombre'] = this.nombre;
    data['email'] = this.email;
    data['Telefono'] = this.telefono;
    data['UrlImagen'] = this.urlImagen;
    return data;
  }
}
