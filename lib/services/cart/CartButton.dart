import 'package:el_gordo/model/PedidoLocal.dart';
import 'package:el_gordo/services/cart/CartPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CartButton extends StatefulWidget {
  @override
  final PedidoLocal carito;
  const CartButton({this.carito});
  _CartButtonState createState() => _CartButtonState();
}

class _CartButtonState extends State<CartButton> {
  var inicio = 0;
  @override
  Widget build(BuildContext context) {
    if (inicio == 0) {
      widget.carito.strm.stream.listen((event) {
        setState(() {
          inicio = 1;
        });
      });
    }
    return Stack(
      alignment: Alignment.topLeft,
      children: [
        IconButton(
          icon: Icon(Icons.shopping_cart),
          color: Colors.blueGrey,
          iconSize: 30,
          onPressed: () {
            if (revisarcarro(widget.carito)) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CartPage(carito: widget.carito,cntx: context,)));
            }
          },
        ),
        revisarcarro(widget.carito)
            ? new Positioned(
                child: new InkWell(
                  child: new Container(
                    padding: const EdgeInsets.all(7.0),
                    decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red,
                    ),
                    child: new Text(widget.carito.pedido.length.toString(),
                        style:
                            new TextStyle(color: Colors.white, fontSize: 12.0)),
                  ),
                ),
                top: 15.0,
                left: 3.0,
              )
            : SizedBox()
      ],
    );
  }
}

bool revisarcarro(PedidoLocal carrito) {
  if (carrito.pedido == null) {
    return false;
  } else {
    return true;
  }
}
