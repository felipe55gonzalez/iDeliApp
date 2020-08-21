class PedidoLocal {
  String idRestaurant;
  String informacion;
  String telefono;
  String dirreccion;
  String userUid;
  String userName;
  String userNumber;
  bool userVerificado;
  List<Pedido> pedido;
  int total;

  PedidoLocal(
      {this.idRestaurant,
      this.informacion,
      this.telefono,
      this.dirreccion,
      this.userUid,
      this.userName,
      this.userNumber,
      this.userVerificado,
      this.pedido,
      this.total});

  PedidoLocal.fromJson(Map<String, dynamic> json) {
    idRestaurant = json['IdRestaurant'];
    informacion = json['Informacion'];
    telefono = json['telefono'];
    dirreccion = json['Dirreccion'];
    userUid = json['UserUid'];
    userName = json['UserName'];
    userNumber = json['UserNumber'];
    userVerificado = json['UserVerificado'];
    if (json['Pedido'] != null) {
      pedido = new List<Pedido>();
      json['Pedido'].forEach((v) {
        pedido.add(new Pedido.fromJson(v));
      });
    }
    total = json['Total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['IdRestaurant'] = this.idRestaurant;
    data['Informacion'] = this.informacion;
    data['telefono'] = this.telefono;
    data['Dirreccion'] = this.dirreccion;
    data['UserUid'] = this.userUid;
    data['UserName'] = this.userName;
    data['UserNumber'] = this.userNumber;
    data['UserVerificado'] = this.userVerificado;
    if (this.pedido != null) {
      data['Pedido'] = this.pedido.map((v) => v.toJson()).toList();
    }
    data['Total'] = this.total;
    return data;
  }
}

class Pedido {
  String nombre;
  String descripcion;
  int precioU;
  int cant;
  int importe;
  String indicacion;
  String img;

  Pedido(
      {this.nombre,
      this.descripcion,
      this.precioU,
      this.cant,
      this.importe,
      this.indicacion,
      this.img});

  Pedido.fromJson(Map<String, dynamic> json) {
    nombre = json['Nombre'];
    descripcion = json['Descripcion'];
    precioU = json['PrecioU'];
    cant = json['cant'];
    importe = json['importe'];
    indicacion = json['indicacion'];
    img = json['Img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Nombre'] = this.nombre;
    data['Descripcion'] = this.descripcion;
    data['PrecioU'] = this.precioU;
    data['cant'] = this.cant;
    data['importe'] = this.importe;
    data['indicacion'] = this.indicacion;
    data['Img'] = this.img;
    return data;
  }
}
