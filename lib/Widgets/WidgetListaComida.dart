import 'dart:convert';
import 'package:el_gordo/Navigation/Info_Place.dart';
import 'package:http/http.dart' as http;
import 'package:el_gordo/model/Comidas.dart';
import 'package:flutter/material.dart';

class WidgetListaComida extends StatefulWidget {
  final bool logged;
  WidgetListaComida({this.logged});
  @override
  _WidgetListaComidaState createState() => _WidgetListaComidaState();
}

class _WidgetListaComidaState extends State<WidgetListaComida> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: loadComidas(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return _listaCard(snapshot.data, widget.logged);
        } else if (snapshot.hasError) {
          return new Text("error");
        }
        return new Center(child: CircularProgressIndicator());
      },
    );
  }
}

Widget _listaCard(ListComida lcomida, bool logged) {
  return Expanded(
      child: ListView.builder(
    scrollDirection: Axis.vertical,
    shrinkWrap: true,
    itemCount: lcomida.comidas.length,
    itemBuilder: (BuildContext ctxt, int index) {
      return Card(
        elevation: 10,
        child: new InkWell(
          onTap: () {
            _cargarInfo(ctxt, lcomida.comidas[index], logged);
          },
          child: Column(
            children: <Widget>[
              ListTile(
                leading: FadeInImage.assetNetwork(
                  width: 70,
                  height: 70,
                  placeholder: 'assets/images/loading.gif',
                  image: lcomida.comidas[index].urlImage,
                  fit: BoxFit.fill,
                ),
                title: Align(
                    alignment: Alignment.centerLeft,
                    child: Column(children: <Widget>[
                      Text(lcomida.comidas[index].nombre),
                      lcomida.comidas[index].estado
                          ? Text(lcomida.comidas[index].mensaje,
                              style: TextStyle(color: Colors.green))
                          : Text(lcomida.comidas[index].mensaje,
                              style: TextStyle(color: Colors.red))
                    ])),
                subtitle: Text(lcomida.comidas[index].dirreccion),
                trailing: Icon(Icons.keyboard_arrow_right),
              ),
            ],
          ),
        ),
      );
    },
  ));
}

Future<ListComida> loadComidas() async {
  ListComida lcomida;
  try {
    var jsonString = await http
        .get("https://expertsystemsacuna.000webhostapp.com/ComidasEstado.php");
    final jsonResponse = json.decode(jsonString.body);
    lcomida = new ListComida.fromJson(jsonResponse);
    return lcomida;
  } catch (_) {
    return lcomida;
  }
}

void _cargarInfo(BuildContext context, Comidas p, bool logged) {
  if (p.estado) {
    Navigator.push(
        context,
        PageRouteBuilder(
            transitionDuration: Duration(milliseconds: 500),
            pageBuilder: (_, __, ___) => InfoPlace(
                  place: p,
                  haveUser: logged,
                )));
  } else {
    _showAlertDialog(context, p,logged);
  }
}

void _showAlertDialog(BuildContext context, Comidas p,bool logged) {
  showDialog(
      context: context,
      builder: (buildcontext) {
        return AlertDialog(
          title: Text("Cerrado"),
          content: Text(
              "Tu eleccion se encuentra cerrada, aun asi puedes ver su menu o productos de venta"),
          actions: <Widget>[
            RaisedButton(
              color: Colors.blueAccent,
              child: Text(
                "Regresar",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            RaisedButton(
              color: Colors.blueAccent,
              child: Text(
                "Continuar",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    PageRouteBuilder(
                        transitionDuration: Duration(milliseconds: 500),
                        pageBuilder: (_, __, ___) => InfoPlace(
                              place: p,
                              haveUser: logged,
                            )));
              },
            )
          ],
        );
      });
}
