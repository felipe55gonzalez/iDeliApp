import 'package:el_gordo/Navigation/Menu.dart';
import 'package:el_gordo/model/ProductosComida.dart';

import 'package:flutter/material.dart';

class TabsMenu extends StatelessWidget {
  final ProductosComida prod;
  final String titulo;

  TabsMenu({this.prod,this.titulo});
  @override
  Widget build(BuildContext context) {
    print(prod.categorias.length);
    return MaterialApp(
      home: DefaultTabController(
        length: prod.categorias.length,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.cyan,
            bottom: TabBar(
              tabs: List<Widget>.generate(prod.categorias.length, (int i) {
                print(i);
                return new Tab(text: prod.categorias[i].nombre);
              }),
            ),
            title: Text("MENU "+new String.fromCharCode(34)+titulo+new String.fromCharCode(34)),
          ),
          body: TabBarView(
            children: List<Widget>.generate(prod.categorias.length, (int i) {
                print(i);
                return WidMenu(lista:prod.categorias[i].lista);
              }),
    
          ),
        ),
      ),
    );
  }
}
