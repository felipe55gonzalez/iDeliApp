import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:el_gordo/model/Galeria.Dart';

class WidgetGaleria extends StatefulWidget {
  final String id, urlGaleria;
  WidgetGaleria({this.id, this.urlGaleria});
  @override
  _WidgetGaleriaState createState() => _WidgetGaleriaState();
}

class _WidgetGaleriaState extends State<WidgetGaleria> {
  int _current = 0;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: loadGaleria(widget.id, widget.urlGaleria),
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
              _loadcarousel(snapshot.data),
            ],
          );
        } else if (snapshot.hasError) {
          return new Text("error");
        }
        return new Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _loadcarousel(Galeria data) {
    return Column(children: [
      CarouselSlider(
          items: data.urls.map((i) {
            return Builder(
              builder: (BuildContext context) {
                return new GestureDetector(
                  onTap: () {},
                  child: Column(
                    children: <Widget>[
                      FadeInImage.assetNetwork(
                        width: (MediaQuery.of(context).size.width) - 100,
                        height: (MediaQuery.of(context).size.height) - 175,
                        placeholder: 'assets/images/loading.gif',
                        image: i.url,
                        fit: BoxFit.fill,
                      )
                    ],
                  ),
                  // )
                );
              },
            );
          }).toList(),
          options: CarouselOptions(
              height: (MediaQuery.of(context).size.height) - 95,
              autoPlay: true,
              enlargeCenterPage: true,
              aspectRatio: 2.0,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              })),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: data.urls.map((i) {
          int index = data.urls.indexOf(i);
          return Container(
            width: 8.0,
            height: 8.0,
            margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: _current == index
                  ? Color.fromRGBO(0, 0, 0, 0.9)
                  : Color.fromRGBO(0, 0, 0, 0.4),
            ),
          );
        }).toList(),
      ),
    ]);
  }
}

Future<Galeria> loadGaleria(String id, String urlGaleria) async {
  Galeria galeria;
  try {
    var jsonString = await http.post(urlGaleria, body: {
      "id": id,
    });

    final jsonResponse = json.decode(jsonString.body);
    galeria = new Galeria.fromJson(jsonResponse);
    return galeria;
  } catch (_) {
    return galeria;
  }
}
