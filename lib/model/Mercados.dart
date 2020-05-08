class ListMercados {
  List<Mercados> mercados;

  ListMercados({this.mercados});

  ListMercados.fromJson(Map<String, dynamic> json) {
    if (json['Mercados'] != null) {
      mercados = new List<Mercados>();
      json['Mercados'].forEach((v) {
        mercados.add(new Mercados.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.mercados != null) {
      data['Mercados'] = this.mercados.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Mercados {
  String idMercado;
  String nombre;
  String urlImage;
  String descripcion;
  String dirreccion;
  String fb;
  String wp;
  String telefono;
  String tags;

  Mercados(
      {this.idMercado,
      this.nombre,
      this.urlImage,
      this.descripcion,
      this.dirreccion,
      this.fb,
      this.wp,
      this.telefono,
      this.tags});

  Mercados.fromJson(Map<String, dynamic> json) {
    idMercado = json['IdMercado'];
    nombre = json['Nombre'];
    urlImage = json['UrlImage'];
    descripcion = json['Descripcion'];
    dirreccion = json['Dirreccion'];
    fb = json['Fb'];
    wp = json['Wp'];
    telefono = json['Telefono'];
    tags = json['Tags'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['IdMercado'] = this.idMercado;
    data['Nombre'] = this.nombre;
    data['UrlImage'] = this.urlImage;
    data['Descripcion'] = this.descripcion;
    data['Dirreccion'] = this.dirreccion;
    data['Fb'] = this.fb;
    data['Wp'] = this.wp;
    data['Telefono'] = this.telefono;
    data['Tags'] = this.tags;
    return data;
  }
}
