import 'package:el_gordo/Navigation/TabsMenu.dart';
import 'package:el_gordo/model/PedidoLocal.dart';
import 'package:el_gordo/model/ProductosComida.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

TextEditingController _textFieldController = TextEditingController();

class AddToCartMenu extends StatefulWidget {
  final Lista producto;
  final PedidoLocal carito;

  const AddToCartMenu({this.carito, this.producto});
  @override
  _AddToCartMenuState createState() => _AddToCartMenuState();
}

class _AddToCartMenuState extends State<AddToCartMenu> {
  int cant = 1;
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              onPressed: () {
                if (cant > 1) {
                  setState(() {
                    cant--;
                  });
                }
              },
              icon: Icon(Icons.remove),
              color: Colors.black,
              iconSize: 30,
            ),
            Container(
              width: 30.0,
              height: 45.0,
              decoration: new BoxDecoration(
                color: Colors.blueGrey,
                border: Border.all(color: Colors.white, width: 2.0),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Center(
                child: Text(
                  cant.toString(),
                  style: new TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  cant++;
                });
              },
              icon: Icon(Icons.add),
              color: Colors.cyan,
              iconSize: 30,
            ),
          ],
        ),
        FlatButton(
          color: Colors.blueGrey,
          textColor: Colors.white,
          disabledColor: Colors.grey,
          disabledTextColor: Colors.black,
          padding: EdgeInsets.all(8.0),
          splashColor: Colors.blueAccent,
          child: Text("Agregar a la Orden"),
          onPressed: () {
            dialogoindicacion(
                context, cant, widget.producto.precio, widget.producto.nombre);
          },
        )
      ],
    ));
  }

  void dialogoindicacion(
      BuildContext cntx, int cantidad, double precio, String nombre) {
    showDialog(
        context: cntx,
        builder: (buildcontext) {
          return AlertDialog(
            title: Text("Agregar a orden"),
            content: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(children: <Widget>[
                  Text("Deseas agregar a tu orden $cantidad $nombre"),
                  Divider(),
                  Text("¿Alguna indicacion?"),
                  TextField(
                    controller: _textFieldController,
                    decoration: InputDecoration(hintText: "Ejemplo: sin tomate"),
                  )
                ])),
            actions: <Widget>[
              RaisedButton(
                color: Colors.blueAccent,
                child: Text(
                  "Cancelar",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  _textFieldController.text="";
                  Navigator.of(cntx, rootNavigator: true).pop();
                },
              ),
              RaisedButton(
                color: Colors.blueAccent,
                child: Text(
                  "Aceptar",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  agregar(_textFieldController.text);
                  _textFieldController.text="";
                  Navigator.of(cntx, rootNavigator: true).pop();
                  setState(() {
                  cant=1;
                });
                },
              )
            ],
          );
        });
  }

  void _buscarYAgregar(String indicacion) {
    var hint = widget.producto.idProducto;
    var r =
        widget.carito.pedido.indexWhere((pedido) => pedido.idProducto == hint);
    if (r != -1) {
      widget.carito.pedido[r].cant = widget.carito.pedido[r].cant + cant;
      widget.carito.pedido[r].importe =
          widget.carito.pedido[r].precioU * widget.carito.pedido[r].cant;
    } else if (r == -1) {
      widget.carito.pedido.add(new Pedido.fromJson({
        "IdProducto": widget.producto.idProducto,
        "Nombre": widget.producto.nombre,
        "Descripcion": widget.producto.descripcion,
        "PrecioU": widget.producto.precio,
        "cant": cant,
        "importe": widget.producto.precio * cant,
        "indicacion":indicacion,
        "Img": widget.producto.imagen
      }));
    }
  }

  void agregar(String indicacion) {
    if (widget.carito.pedido == null) {
      widget.carito.pedido = [];
      widget.carito.pedido.add(new Pedido.fromJson({
        "IdProducto": widget.producto.idProducto,
        "Nombre": widget.producto.nombre,
        "Descripcion": widget.producto.descripcion,
        "PrecioU": widget.producto.precio,
        "cant": cant,
        "importe": widget.producto.precio * cant,
        "indicacion": indicacion,
        "Img": widget.producto.imagen
      }));
    } else {
      _buscarYAgregar(indicacion);
    }
    _imprcarito();
  }

  void _imprcarito() {
    var s = widget.carito.pedido.length;
    for (int i = 0; i < s; i++) {
      print("==========================================================================");
      print("==========================================================================");
      print(widget.carito.pedido[i].toJson());
      print("==========================================================================");
      print("==========================================================================");
    }
    widget.carito.strm.add("hola");
  }
}
