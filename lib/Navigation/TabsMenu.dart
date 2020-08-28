import 'dart:async';

import 'package:el_gordo/Cuenta/modelUserdataDb.dart';
import 'package:el_gordo/Navigation/Menu.dart';
import 'package:el_gordo/model/Comidas.dart';
import 'package:el_gordo/model/PedidoLocal.dart';
import 'package:el_gordo/model/ProductosComida.dart';
import 'package:el_gordo/services/cart/CartButton.dart';

import 'package:flutter/material.dart';



class TabsMenu extends StatelessWidget {
  final ProductosComida prod;
  final String titulo;
  final bool haveUser;
  final Comidas place;
  final Data userdataFromDB;

  TabsMenu(
      {this.prod, this.titulo, this.haveUser, this.place, this.userdataFromDB});

  @override
  Widget build(BuildContext context) {
    PedidoLocal carito = new PedidoLocal();

    if (haveUser) {
      carito.nombrelocal=place.nombre;
      carito.idRestaurant = place.idRestaurante;
      carito.informacion = place.descripcion;
      carito.dirreccion = place.dirreccion;
      carito.telefono = place.telefono;
      carito.userName = userdataFromDB.nombre;
      carito.userNumber = userdataFromDB.telefono;
      carito.userUid = userdataFromDB.uid;
      carito.strm = new StreamController();
    }

    return WillPopScope(
      onWillPop: () async {
            carito.strm.close();
            print("=============================================");
            print("=============================================");
            print("===============Saliste=======================");
            print("=============================================");
            print("=============================================");
            return true;
        }, 
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: DefaultTabController(
          length: prod.categorias.length,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.cyan,
              bottom: TabBar(
                tabs: List<Widget>.generate(prod.categorias.length, (int i) {
                  return new Tab(text: prod.categorias[i].nombre);
                }),
              ),
              title: Text("MENU " +
                  new String.fromCharCode(34) +
                  titulo +
                  new String.fromCharCode(34)),
              actions: <Widget>[
                haveUser
                    ? CartButton(
                        carito: carito,
                      )
                    : SizedBox(
                        height: 3,
                      )
              ],
            ),
            body: TabBarView(
              children: List<Widget>.generate(prod.categorias.length, (int i) {
                return WidMenu(
                  lista: prod.categorias[i].lista,
                  haveUser: haveUser,
                  place: place,
                  carito: carito,
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
