import 'package:flutter/material.dart';
import 'package:justy_app/src/forms/form_alumnos.dart';
import 'package:justy_app/src/forms/form_docentes.dart';
import 'package:justy_app/src/forms/form_grupo.dart';

import 'package:justy_app/src/forms/form_justificaciones.dart';
import 'package:justy_app/src/listas/alumnos_lista.dart';
import 'package:justy_app/src/listas/docentes_lista.dart';
import 'package:justy_app/src/listas/justificaciones_lista.dart';

import 'package:justy_app/src/pages/homepage.dart';


import 'package:justy_app/src/pages/inicio_page.dart';

import 'package:justy_app/src/pages/login_page.dart';
import 'package:justy_app/src/pages/registro_page.dart';

import 'src/listas/grupos_lista.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});

 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'material app',
      debugShowCheckedModeBanner: false,
      initialRoute: 'homepage',
      routes: {
        'homepage': (BuildContext context) => HomePage(),
        'login': (BuildContext context) => LoginPage(),
        'registro': (BuildContext context) => RegistroPage(),
        'inicio': (BuildContext context) => PaginaInit(),
        'grupos': (BuildContext context) => ListGrupos(),
        'alumnos': (BuildContext context) => AlumnosLista(),
        'docentes': (BuildContext context) => DocentesLista(),
        'justificaciones': (BuildContext context) => JustificacionesLista(),
        'formalumnos': (BuildContext context) => AlumnoPage(),
        'formdocentes': (BuildContext context) => DocentesPage(),
        'formgrupo': (BuildContext context) => GrupoPage(),
        'formjusti': (BuildContext context) => JustificacionPage(),
      },
    );
  }
}

