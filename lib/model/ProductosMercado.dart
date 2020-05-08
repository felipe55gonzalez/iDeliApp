class ProductosMercado {
  List<Categorias> categorias;

  ProductosMercado({this.categorias});

  ProductosMercado.fromJson(Map<String, dynamic> json) {
    if (json['Categorias'] != null) {
      categorias = new List<Categorias>();
      json['Categorias'].forEach((v) {
        categorias.add(new Categorias.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.categorias != null) {
      data['Categorias'] = this.categorias.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Categorias {
  String nombre;
  List<Lista> lista;

  Categorias({this.nombre, this.lista});

  Categorias.fromJson(Map<String, dynamic> json) {
    nombre = json['Nombre'];
    if (json['Lista'] != null) {
      lista = new List<Lista>();
      json['Lista'].forEach((v) {
        lista.add(new Lista.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Nombre'] = this.nombre;
    if (this.lista != null) {
      data['Lista'] = this.lista.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Lista {
  String idProducto;
  String idMercado;
  String nombre;
  String descripcion;
  String disponible;
  String precio;
  String imagen;
  String categoria;
  String lunes;
  String martes;
  String miercoles;
  String jueves;
  String viernes;
  String sabado;
  String domingo;

  Lista(
      {this.idProducto,
      this.idMercado,
      this.nombre,
      this.descripcion,
      this.disponible,
      this.precio,
      this.imagen,
      this.categoria,
      this.lunes,
      this.martes,
      this.miercoles,
      this.jueves,
      this.viernes,
      this.sabado,
      this.domingo});

  Lista.fromJson(Map<String, dynamic> json) {
    idProducto = json['IdProducto'];
    idMercado = json['IdMercado'];
    nombre = json['Nombre'];
    descripcion = json['Descripcion'];
    disponible = json['Disponible'];
    precio = json['Precio'];
    imagen = json['Imagen'];
    categoria = json['Categoria'];
    lunes = json['Lunes'];
    martes = json['Martes'];
    miercoles = json['Miercoles'];
    jueves = json['Jueves'];
    viernes = json['Viernes'];
    sabado = json['Sabado'];
    domingo = json['Domingo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['IdProducto'] = this.idProducto;
    data['IdMercado'] = this.idMercado;
    data['Nombre'] = this.nombre;
    data['Descripcion'] = this.descripcion;
    data['Disponible'] = this.disponible;
    data['Precio'] = this.precio;
    data['Imagen'] = this.imagen;
    data['Categoria'] = this.categoria;
    data['Lunes'] = this.lunes;
    data['Martes'] = this.martes;
    data['Miercoles'] = this.miercoles;
    data['Jueves'] = this.jueves;
    data['Viernes'] = this.viernes;
    data['Sabado'] = this.sabado;
    data['Domingo'] = this.domingo;
    return data;
  }
}
