class ListComida {
  List<Comidas> comidas;

  ListComida({this.comidas});

  ListComida.fromJson(Map<String, dynamic> json) {
    if (json['Comidas'] != null) {
      comidas = new List<Comidas>();
      json['Comidas'].forEach((v) {
        comidas.add(new Comidas.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.comidas != null) {
      data['Comidas'] = this.comidas.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Comidas {
  String idRestaurante;
  String nombre;
  String urlImage;
  String descripcion;
  String dirreccion;
  String fb;
  String wp;
  String telefono;
  String tags;
  String mensaje;
  bool estado;

  Comidas(
      {this.idRestaurante,
      this.nombre,
      this.urlImage,
      this.descripcion,
      this.dirreccion,
      this.fb,
      this.wp,
      this.telefono,
      this.tags,
      this.mensaje,
      this.estado});

  Comidas.fromJson(Map<String, dynamic> json) {
    idRestaurante = json['IdRestaurante'];
    nombre = json['Nombre'];
    urlImage = json['UrlImage'];
    descripcion = json['Descripcion'];
    dirreccion = json['Dirreccion'];
    fb = json['Fb'];
    wp = json['Wp'];
    telefono = json['Telefono'];
    tags = json['Tags'];
    mensaje = json['Mensaje'];
    estado=json['Estado'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['IdRestaurante'] = this.idRestaurante;
    data['Nombre'] = this.nombre;
    data['UrlImage'] = this.urlImage;
    data['Descripcion'] = this.descripcion;
    data['Dirreccion'] = this.dirreccion;
    data['Fb'] = this.fb;
    data['Wp'] = this.wp;
    data['Telefono'] = this.telefono;
    data['Tags'] = this.tags;
    data['Mensaje']=this.mensaje;
    data['Estado']=this.estado;
    return data;
  }
}
