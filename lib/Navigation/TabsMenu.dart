import 'package:el_gordo/Cuenta/modelUserdataDb.dart';
import 'package:el_gordo/Navigation/Menu.dart';
import 'package:el_gordo/model/Comidas.dart';
import 'package:el_gordo/model/PedidoLocal.dart';
import 'package:el_gordo/model/ProductosComida.dart';

import 'package:flutter/material.dart';
  PedidoLocal carito = new PedidoLocal();
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
    carito = new PedidoLocal();
    if (haveUser) {    
      carito.idRestaurant = place.idRestaurante;
      carito.informacion = place.descripcion;
      carito.dirreccion = place.dirreccion;
      carito.telefono = place.telefono;
      carito.userName = userdataFromDB.nombre;
      carito.userNumber = userdataFromDB.telefono;
      carito.userUid = userdataFromDB.uid;
    }

    return MaterialApp(
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
                  ? IconButton(
                      icon: Icon(Icons.shopping_cart),
                      color: Colors.blueGrey,
                      iconSize: 30,
                      onPressed: () {},
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
    );
  }
}
