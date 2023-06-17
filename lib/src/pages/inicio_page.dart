import 'package:flutter/material.dart';

class PaginaInit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(253, 252, 251, 1.000),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(91, 74, 66, 1.000),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 100.0),
            child: Text('Bienvenido(a)',
                style: TextStyle(
                    color: Color.fromRGBO(91, 74, 66, 1.000), fontSize: 35.0)),
          ),
          Container(
            child: Image(image: AssetImage('assets/fondopng.png')),
          ),
        ],
      ),
      drawer: _menuWidget(),
    );
  }
}

class _menuWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        backgroundColor: Color.fromRGBO(246, 231, 211, 1.000),
        //Pasamos un listView para poder hacer scroll si hay muchos
        child: ListView(
          //quite el padding
          children: [
            DrawerHeader(
              child: Container(),
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage('assets/menu.png'),
              )),
            ),

            Divider(
              height: 20.0,
              thickness: 5.0,
              indent: 30.0,
              endIndent: 30.0,
              color: Color.fromRGBO(91, 74, 66, 1.000),
            ),

            //Opciones del menu
            ListTile(
              title: Text(
                'Inicio',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color.fromRGBO(91, 74, 66, 1.000), fontSize: 20.0),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),

            Divider(
              height: 20.0,
              thickness: 5.0,
              indent: 30.0,
              endIndent: 30.0,
              color: Color.fromRGBO(91, 74, 66, 1.000),
            ),

            ListTile(
              title: Text(
                'Lista de alumnos',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color.fromRGBO(91, 74, 66, 1.000), fontSize: 20.0),
              ),
              onTap: () {
                Navigator.pushNamed(context, 'alumnos');
              },
            ),

            Divider(
              height: 20.0,
              thickness: 5.0,
              indent: 30.0,
              endIndent: 30.0,
              color: Color.fromRGBO(91, 74, 66, 1.000),
            ),

            ListTile(
              title: Text(
                'Lista de docentes',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color.fromRGBO(91, 74, 66, 1.000), fontSize: 20.0),
              ),
              onTap: () {
                Navigator.pushNamed(context, 'docentes');
              },
            ),

            Divider(
              height: 20.0,
              thickness: 5.0,
              indent: 30.0,
              endIndent: 30.0,
              color: Color.fromRGBO(91, 74, 66, 1.000),
            ),

            ListTile(
              title: Text(
                'Grupos',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color.fromRGBO(91, 74, 66, 1.000), fontSize: 20.0),
              ),
              onTap: () {
                //Navigator.pop(context);
                Navigator.pushNamed(context, 'grupos');
              },
            ),

            Divider(
              height: 20.0,
              thickness: 5.0,
              indent: 30.0,
              endIndent: 30.0,
              color: Color.fromRGBO(91, 74, 66, 1.000),
            ),

            ListTile(
              title: Text(
                'Justificaciones',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color.fromRGBO(91, 74, 66, 1.000), fontSize: 20.0),
              ),
              onTap: () {
                // Navigator.pop(context);
                Navigator.pushNamed(context, 'justificaciones');
              },
            ),

            Divider(
              height: 20.0,
              thickness: 5.0,
              indent: 30.0,
              endIndent: 30.0,
              color: Color.fromRGBO(91, 74, 66, 1.000),
            ),

            ListTile(
              title: Text(
                'Salir',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color.fromRGBO(91, 74, 66, 1.000), fontSize: 20.0),
              ),
              onTap: () {
                //Navigator.pop(context);
                Navigator.pushNamed(context, 'login');
              },
            ),
          ],
        ),
      ),
    );
  }
}
