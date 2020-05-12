import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddToCartMenu extends StatefulWidget {
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
          onPressed: () {},
        )
      ],
    ));
  }
}
