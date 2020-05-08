import 'dart:convert';

import 'package:el_gordo/Navigation/TabsMenu.dart';
import 'package:el_gordo/Widgets/GaleriaW.dart';

import 'package:el_gordo/model/Mercados.dart';
import 'package:el_gordo/model/ProductosComida.dart';
import 'package:flutter/material.dart';
import 'package:el_gordo/Widgets/circular_clipper.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

bool _notloading = true;

class Infomercado extends StatefulWidget {
  final Mercados mercado;

  Infomercado({this.mercado});

  @override
  _InfomercadoState createState() => _InfomercadoState();
}

class _InfomercadoState extends State<Infomercado> {
  @override
  Widget build(BuildContext context) {
    bool fb = false, wp = false;
    if (widget.mercado.fb.length > 0) {
      fb = true;
    }
    if (widget.mercado.wp.length > 0) {
      wp = true;
    }
    return Scaffold(
        backgroundColor: Colors.white,
        body: ListView(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  transform: Matrix4.translationValues(0.0, -50.0, 0.0),
                  child: ClipShadowPath(
                      clipper: CircularClipper(),
                      shadow: Shadow(blurRadius: 20.0),
                      child: Hero(
                        tag: widget.mercado.idMercado,
                        child: Image(
                          height: 250.0,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          image: new NetworkImage(widget.mercado.urlImage),
                        ),
                      )),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      padding: EdgeInsets.only(left: 30.0),
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.arrow_back),
                      iconSize: 30.0,
                      color: Colors.black,
                    )
                  ],
                ),
                Positioned.fill(
                  bottom: 3.0,
                  child: Align(
                      alignment: Alignment.bottomCenter,
                      child: _notloading
                          ? RawMaterialButton(
                              padding: EdgeInsets.all(10.0),
                              elevation: 15.0,
                              onPressed: () {
                                setState(() {
                                  _notloading = false;
                                  loadProductos(context, widget.mercado.nombre,
                                      widget.mercado.idMercado);
                                });
                              },
                              shape: CircleBorder(),
                              fillColor: Colors.white,
                              child: Stack(children: <Widget>[
                                Positioned(
                                    child: Text("Productos",
                                        style: GoogleFonts.acme(fontSize: 15)),
                                    bottom: 5,
                                    left: 8),
                                Icon(
                                  Icons.art_track,
                                  size: 65.0,
                                  color: Colors.blue,
                                )
                              ]))
                          : CircularProgressIndicator()),
                ),
                Positioned(
                    bottom: 0.0,
                    left: 20.0,
                    child: wp
                        ? GestureDetector(
                            onTap: () {
                              FlutterOpenWhatsapp.sendSingleMessage(
                                  "+52" + widget.mercado.wp, "");
                            },
                            child: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30.0),
                                  boxShadow: [
                                    BoxShadow(
                                        blurRadius: 6.0,
                                        color: Colors.black.withOpacity(0.4),
                                        spreadRadius: 2.0)
                                  ]),
                              child: Image(
                                image: AssetImage('assets/images/wp.png'),
                                height: 60.0,
                                width: 150.0,
                              ),
                            ))
                        : SizedBox()),
                Positioned(
                    bottom: 0.0,
                    right: 25.0,
                    child: fb
                        ? GestureDetector(
                            onTap: () {
                              openFacebook(widget.mercado.fb);
                            },
                            child: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30.0),
                                  boxShadow: [
                                    BoxShadow(
                                        blurRadius: 6.0,
                                        color: Colors.black.withOpacity(0.4),
                                        spreadRadius: 2.0)
                                  ]),
                              child: Image(
                                image: AssetImage('assets/images/fb.png'),
                                height: 60.0,
                                width: 150.0,
                              ),
                            ))
                        : SizedBox())
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    widget.mercado.nombre.toUpperCase(),
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    widget.mercado.dirreccion.toUpperCase(),
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 16.0,
                    ),
                  ),
                  SizedBox(height: 12.0),
                  Text(
                    '⭐ ⭐ ⭐ ⭐',
                    style: TextStyle(fontSize: 25.0),
                  ),
                  SizedBox(height: 15.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Text(
                            'Year',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 16.0,
                            ),
                          ),
                          SizedBox(height: 2.0),
                          Text(
                            "Año",
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Text(
                            'Country',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 16.0,
                            ),
                          ),
                          SizedBox(height: 2.0),
                          Text(
                            widget.mercado.descripcion.toString(),
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Text(
                            'Length',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 16.0,
                            ),
                          ),
                          SizedBox(height: 2.0),
                          Text(
                            '${32} min',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 30.0),
                  Container(
                    height: 20.0,
                    child: SingleChildScrollView(
                      child: Text(
                        "Galeria",
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            WidgetGaleria(
                id: widget.mercado.idMercado,
                urlGaleria:
                    "http://expertsystemsacuna.000webhostapp.com/Mercados/GaleriaMercados.php")
          ],
        ));
  }
}

Future<void> openFacebook(String url) async {
  try {
    bool launched = await launch(url, forceSafariVC: false);

    if (!launched) {
      await launch(url, forceSafariVC: false);
    }
  } catch (e) {
    await launch(url, forceSafariVC: false);
  }
}

Future loadProductos(BuildContext context, String name, String id) async {
  ProductosComida productos;
  try {
    var url =
        "https://expertsystemsacuna.000webhostapp.com/Mercados/SelectFProductos.php";
    var jsonString = await http.post(url, body: {
      "id": id,
    });
    _notloading = true;
    print(jsonString.body);
    final jsonResponse = json.decode(jsonString.body);
    productos = new ProductosComida.fromJson(jsonResponse);
    Navigator.push(
        context,
        PageRouteBuilder(
            transitionDuration: Duration(milliseconds: 500),
            pageBuilder: (_, __, ___) =>
                TabsMenu(prod: productos, titulo: name)));
  } catch (_) {}
}
