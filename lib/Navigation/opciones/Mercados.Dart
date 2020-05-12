import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:el_gordo/Navigation/opciones/Info_Mercado.dart';
import 'package:el_gordo/model/Mercados.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

Color gradientStart = Colors.lightBlue; //Change start gradient color here
Color gradientEnd = Colors.cyan;

class Mercado extends StatefulWidget {
  @override
  _MercadoState createState() => _MercadoState();
}

class _MercadoState extends State<Mercado> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(
        gradient: new LinearGradient(
            colors: [gradientStart, gradientEnd],
            begin: const FractionalOffset(0.5, 0.0),
            end: const FractionalOffset(0.0, 0.5),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp),
      ),
      child: FutureBuilder(
        future: loadplaces(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: <Widget>[
                Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      "A donde ir",
                      style: GoogleFonts.fredokaOne(
                          fontSize: 17, color: Colors.white),
                      textAlign: TextAlign.left,
                    )),
                _carousel(snapshot.data),
              ],
            );
          } else if (snapshot.hasError) {
            return new Text("error");
          }
          return new Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  static Widget _carousel(ListMercados pls) {
    return CarouselSlider(
      items: pls.mercados.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return new GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      PageRouteBuilder(
                          transitionDuration: Duration(milliseconds: 500),
                          pageBuilder: (_, __, ___) =>
                              Infomercado(mercado: i)));
                },
                child: Container(
                  height: 190.0,
                  width: (MediaQuery.of(context).size.width) - 100,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15.0),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 6.0,
                            color: Colors.black.withOpacity(0.4),
                            spreadRadius: 2.0)
                      ]),
                  child: Column(
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          Hero(
                              tag: i.idMercado,
                              child: Container(
                                height: 250.0,
                                child: FadeInImage.assetNetwork(
                                  width:
                                      (MediaQuery.of(context).size.width) - 80,
                                  height: (MediaQuery.of(context).size.height) -
                                      100,
                                  placeholder: 'assets/images/loading.gif',
                                  image: i.urlImage,
                                  fit: BoxFit.fill,
                                ),
                              )),
                        ],
                      ),
                      SizedBox(height: 3.0),
                      Text(
                        i.nombre,
                        style: GoogleFonts.bangers(fontSize: 19),
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        i.descripcion,
                        style: GoogleFonts.bangers(
                            fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                ));
          },
        );
      }).toList(),
      options: CarouselOptions(
        height: 400.0,
        enlargeCenterPage: true,
        enableInfiniteScroll: false,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 5),
        autoPlayAnimationDuration: Duration(milliseconds: 1200),
      ),
    );
  }
}

Future<ListMercados> loadplaces() async {
  ListMercados toplist;
  try {
    var jsonString = await http.get(
        "http://expertsystemsacuna.000webhostapp.com/Mercados/Mercados.php");
    final jsonResponse = json.decode(jsonString.body);
    toplist = new ListMercados.fromJson(jsonResponse);
    return toplist;
  } catch (_) {
    return toplist;
  }
}
