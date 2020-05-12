import 'package:el_gordo/Navigation/Menu.dart';
import 'package:el_gordo/model/ProductosComida.dart';

import 'package:flutter/material.dart';

class TabsMenu extends StatelessWidget {
  final ProductosComida prod;
  final String titulo;
  final bool haveUser;

  TabsMenu({this.prod, this.titulo,this.haveUser});
  @override
  Widget build(BuildContext context) {
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
              haveUser?
              IconButton(
                icon: Icon(Icons.shopping_cart),
                color: Colors.blueGrey,
                iconSize: 30,
                onPressed: () {},
              ):
              SizedBox(height: 3,)
            ],
          ),
          body: TabBarView(
            children: List<Widget>.generate(prod.categorias.length, (int i) {
              return WidMenu(lista: prod.categorias[i].lista,haveUser:haveUser);
            }),
          ),
        ),
      ),
    );
  }
}
