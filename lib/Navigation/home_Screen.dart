import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:el_gordo/Navigation/Info_Place.dart';
import 'package:el_gordo/Widgets/WidgetListaComida.dart';
import 'package:el_gordo/model/Comidas.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:el_gordo/Navigation/opciones/Mercados.Dart';

Color gradientStart = Colors.lightBlue; //Change start gradient color here
Color gradientEnd = Colors.cyan; //Change end gradient color here

int _selectedIndex = 0;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  final List<Widget> _widgetOptions = <Widget>[
    _opcion(),
    Mercado(),
    Text(
      'Proximamente',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.fastfood),
            title: Text('Comida'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.store_mall_directory),
            title: Text('Supermercados'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.trending_up),
            title: Text('Tendencias'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
      appBar: new AppBar(
        title: new Text(
          "iDeli Acuña",
          style: GoogleFonts.fredokaOne(fontSize: 30),
        ),
        backgroundColor: Colors.cyan,
        centerTitle: true,
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
    );
  }

  static Widget _opcion() {
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
        future: loadComidas(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
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
                WidgetListaComida()
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

  static Widget _carousel(ListComida pls) {
    return CarouselSlider(
      items: pls.comidas.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return new GestureDetector(
                onTap: () {
                  _cargarInfo(context, i);
                },
                child: Container(
                  height: 25.0,
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
                              tag: i.idRestaurante,
                              child: Container(
                                height: 135.0,
                                child: FadeInImage.assetNetwork(
                                  width:
                                      (MediaQuery.of(context).size.width) - 100,
                                  height: (MediaQuery.of(context).size.height) -
                                      155,
                                  placeholder: 'assets/images/loading.gif',
                                  image: i.urlImage,
                                  fit: BoxFit.fill,
                                ),
                              ))
                        ],
                      ),
                      SizedBox(height: 1.0),
                      Text(
                        i.nombre,
                        style: GoogleFonts.bangers(fontSize: 19),
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        i.dirreccion,
                        style: GoogleFonts.bangers(
                            fontSize: 14, color: Colors.grey),
                      ),
                      i.estado
                          ? Text(
                              i.mensaje,
                              style: GoogleFonts.bangers(
                                  fontSize: 18, color: Colors.green),
                            )
                          : Text(
                              i.mensaje,
                              style: GoogleFonts.bangers(
                                  fontSize: 18, color: Colors.red),
                            )
                    ],
                  ),
                ));
          },
        );
      }).toList(),
      options: CarouselOptions(
        height: 210.0,
        enlargeCenterPage: true,
        enableInfiniteScroll: false,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 5),
        autoPlayAnimationDuration: Duration(milliseconds: 1200),
      ),
    );
  }
}

Future<ListComida> loadComidas() async {
  ListComida lcomida;
  try {
    var jsonString = await http.get(
        "http://expertsystemsacuna.000webhostapp.com/ComidasEstadoTop.php");
    final jsonResponse = json.decode(jsonString.body);
    lcomida = new ListComida.fromJson(jsonResponse);
    return lcomida;
  } catch (_) {
    return lcomida;
  }
}

void _cargarInfo(BuildContext context, Comidas p) {
  if (p.estado) {
    Navigator.push(
        context,
        PageRouteBuilder(
            transitionDuration: Duration(milliseconds: 500),
            pageBuilder: (_, __, ___) => InfoPlace(place: p)));
  } else {
    _showAlertDialog(context, p);
  }
}

void _showAlertDialog(BuildContext context, Comidas p) {
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
                        pageBuilder: (_, __, ___) => InfoPlace(place: p)));
              },
            )
          ],
        );
      });
}
