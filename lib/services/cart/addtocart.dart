import 'package:el_gordo/model/Comidas.dart';
import 'package:el_gordo/model/PedidoLocal.dart';
import 'package:el_gordo/model/ProductosComida.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
            if (widget.carito.pedido == null) {
              widget.carito.pedido=[];
              print("listo para cargar al carito");              
              widget.carito.pedido.add(new Pedido.fromJson({
                "Nombre": widget.producto.nombre,
                "Descripcion":
                    widget.producto.descripcion,
                "PrecioU": double.parse(widget.producto.precio),
                "cant": cant,
                "importe": double.parse(widget.producto.precio)*cant,
                "indicacion": "bien dorados",
                "Img":
                    widget.producto.imagen
              }));
              
            } else {
                print(widget.carito.pedido[0].descripcion);
                print(widget.carito.pedido[0].precioU);
                print(widget.carito.pedido[0].importe);
            }
          },
        )
      ],
    ));
  }
}
