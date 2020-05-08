import 'package:carousel_slider/carousel_slider.dart';
import 'package:el_gordo/model/ProductosComida.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class WidMenu extends StatefulWidget {
  final List<Lista> lista;

  WidMenu({this.lista});
  @override
  _WidMenuState createState() => _WidMenuState();
}

class _WidMenuState extends State<WidMenu> {
  int _current = 0;
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      CarouselSlider(
          items: widget.lista.map((i) {
            return Builder(
              builder: (BuildContext context) {
                return new GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: (MediaQuery.of(context).size.height) - 200,
                      width: (MediaQuery.of(context).size.width) - 120,
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
                              Container(
                                height:
                                    (MediaQuery.of(context).size.height) - 400,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10.0),
                                        topRight: Radius.circular(10.0)),
                                    image: DecorationImage(
                                        image: new NetworkImage(i.imagen),
                                        fit: BoxFit.fill)),
                              ),
                            ],
                          ),
                          Text(
                            i.nombre,
                            style: TextStyle(
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 10.0),
                          Text(
                            new String.fromCharCode(36) + i.precio,
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 25.0,
                            ),
                          ),
                          Text(
                            i.descripcion,
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 20.0,
                            ),
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    ));
              },
            );
          }).toList(),
          options: CarouselOptions(
              height: (MediaQuery.of(context).size.height) - 165,
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
        children: widget.lista.map((i) {
          int index = widget.lista.indexOf(i);
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
