import 'package:el_gordo/Cuenta/modelUserdataDb.dart';
import 'package:flutter/material.dart';

class InfocuentaPage extends StatefulWidget {
  final Data userData;
  InfocuentaPage({this.userData});
  @override
  _InfocuentaPageState createState() => _InfocuentaPageState();
}

class _InfocuentaPageState extends State<InfocuentaPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new Stack(
      children: <Widget>[
        ClipPath(
          child: Container(color: Colors.cyan),
          clipper: getClipper(),
        ),
        Positioned(
            width: 350.0,
            top: 30,
            child: Column(
              children: <Widget>[
                Container(
                    width: 80.0,
                    height: 80.0,
                    decoration: BoxDecoration(
                        color: Colors.red,
                        image: DecorationImage(
                            image: NetworkImage(widget.userData.urlImagen),
                            fit: BoxFit.cover),
                        borderRadius: BorderRadius.all(Radius.circular(75.0)),
                        boxShadow: [
                          BoxShadow(blurRadius: 7.0, color: Colors.black)
                        ])),
                SizedBox(height: 5.0),
                Card(
                  elevation: 5,
                  child: Container(
                    width: 450.0,
                    height: 130.0,
                    child: Column(
                      children: <Widget>[
                        Text(
                          widget.userData.nombre,
                          style: TextStyle(
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat'),
                        ),
                        SizedBox(height: 5.0),
                        Text(
                          widget.userData.email,
                          style: TextStyle(
                              color: Colors.black.withOpacity(.5),
                              fontSize: 17.0,
                              fontStyle: FontStyle.italic,
                              fontFamily: 'Montserrat'),
                        ),
                        Text(
                          widget.userData.telefono,
                          style: TextStyle(
                              color: Colors.black.withOpacity(.5),
                              fontSize: 17.0,
                              fontStyle: FontStyle.italic,
                              fontFamily: 'Montserrat'),
                        ),
                        Stack(
                          children: <Widget>[
                            FlatButton(
                              color: Colors.cyan,
                              textColor: Colors.white,
                              disabledColor: Colors.grey,
                              disabledTextColor: Colors.black,
                              padding: EdgeInsets.all(8.0),
                              splashColor: Colors.blueAccent,
                              child: Text("Editar"),
                              onPressed: () {},
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ))
      ],
    ));
  }
}

class getClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();

    path.lineTo(0.0, size.height / 1.9);
    path.lineTo(size.width + 125, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
}
