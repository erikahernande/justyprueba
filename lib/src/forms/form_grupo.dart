import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GrupoPage extends StatefulWidget {
  @override
  State<GrupoPage> createState() => _GrupoPageState();
}

class _GrupoPageState extends State<GrupoPage> {
  TextEditingController nomenclaturaController = TextEditingController();
  TextEditingController aulaController = TextEditingController();
//String _docenteSele = 'Noé Solis';

  List<String> _docenteGrad = [
    'Noé Solis',
    'Casimiro Uuh',
    'René Canul',
    'Raul Ortiz',
    'Martin Ortiz',
    'Zunne Poot'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _crearFondo(context),
          _crearLogin(context),
        ],
      ),
    );
  }

  Future<int> _crearGrupo(String nomenclatura, String aula) async {
    try {
      final response = await http.post(
          Uri.parse("http://127.0.0.1/justy/agregargrup.php"),
          body: {"nomenclatura": nomenclatura, "aula": aula});

      if (response.statusCode == 200) {
        print("vamos los pibes");
        var datauser = json.decode(response.body);
        var mensaje = datauser.toString();

        if (mensaje == "Success") {
          // La consulta fue exitosa
          print("Inicio de sesión exitoso");
          return 1;
        } else {
          // La consulta no fue exitosa
          print("Error");
          return 0;
        }

        // if (datauser.lenght == 0) {
        //   print("errrrrrrrroooooooooooorrrrrrrrrrrrrrrr");
        // } else {
        //   print("piolaaaaaaaaaaaaaaaaaaaa");
        // }
      }
    } catch (e) {
      print("ufff, entró en el catch");
      print(e);
      return 0;
    }
    return 0;
  }

  Widget _crearLogin(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SafeArea(
              child: Container(
            height: 220.0,
          )),
          Container(
            width: size.width * 0.90,
            margin: EdgeInsets.symmetric(vertical: 20.0),
            padding: EdgeInsets.all(10),
            //padding: EdgeInsets.symmetric(vertical: 50.0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5.0),
                // sombreado
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.white,
                      blurRadius: 3.0,
                      offset: Offset(0.0, 5.0),
                      spreadRadius: 2.0)
                ]),
            child: Form(
              child: Column(
                children: <Widget>[
                  Text(
                    'Registro de grupos',
                    style: TextStyle(
                        fontSize: 30.0,
                        color: Color(0xFFFF5B4A42),
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  _crearNomenclatura(),
                  SizedBox(
                    height: 30.0,
                  ),
                  _crearAula(),
                  SizedBox(
                    height: 30.0,
                  ),

                  SizedBox(
                    height: 30.0,
                  ),

                  _crearBoton(),
                  SizedBox(
                    height: 30.0,
                  ),
                  // _crearBoton(bloc)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _crearNomenclatura() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Nomenclatura',
          style: TextStyle(
              color: Color(0xFFFF5B4A42),
              fontSize: 16,
              fontWeight: FontWeight.w500),
          textAlign: TextAlign.end,
        ),
        SizedBox(
          height: 15,
        ),
        Material(
          //shadowColor: ShadowColo,

          child: TextFormField(
            controller: nomenclaturaController,
            decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.numbers,
                  color: Colors.black,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                hintText: '',
                enabledBorder: borde(),
                focusedBorder: borde()),
          ),
        )
      ],
    );
  }

  Widget _crearAula() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Aula',
          style: TextStyle(
              color: Color(0xFFFF5B4A42),
              fontSize: 16,
              fontWeight: FontWeight.w500),
          textAlign: TextAlign.end,
        ),
        SizedBox(
          height: 15,
        ),
        TextFormField(
          controller: aulaController,
          decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.doorbell,
                color: Colors.black,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              hintText: '',
              enabledBorder: borde(),
              focusedBorder: borde()),
        ),
      ],
    );
  }

  List<DropdownMenuItem<String>> getOpcionesDropdown() {
    List<DropdownMenuItem<String>> lista = [];

    _docenteGrad.forEach((opcion) {
      lista.add(DropdownMenuItem(
        child: Text(opcion),
        value: opcion,
      ));
    });

    return lista;
  }

  Widget _crearBoton() {
    return ElevatedButton(
      // padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),

      child: Text(
        'Guardar',
        style: TextStyle(
          fontSize: 20,
        ),
      ),
      style: ElevatedButton.styleFrom(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
        padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
        elevation: 0.0,
        backgroundColor: Color(0xFFFFB8876D),
      ),
      onPressed: () async {
        if (nomenclaturaController.text.length > 0 &&
            aulaController.text.length > 0) {
          if (await _crearGrupo(
                  nomenclaturaController.text, aulaController.text) >
              0) {
            print("Exitoso guardado");
          } else {
            print("No se guardó");
          }
        }
      },
      //onPressed: snapshot.hasData ? () => _login(bloc, context) : null,
    );
  }

  OutlineInputBorder borde() {
    //return type is OutlineInputBorder
    return OutlineInputBorder(
        //Outline border type for TextFeild
        borderRadius: BorderRadius.all(Radius.circular(30)),
        borderSide: BorderSide(
          color: Color(0xFFFF5B4A42),
          width: 1.5,
        ));
  }

  Widget _crearFondo(BuildContext context) {
    // final size = MediaQuery.of(context).size;

    final fondo = Container(
      height: 220,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Color(0xFFFF6E7D3), borderRadius: BorderRadius.circular(50.0)),
    );

    return Stack(
      children: <Widget>[
        fondo,
        Container(
          padding: EdgeInsets.only(top: 60),
          child: Column(
            children: <Widget>[
              Image.asset('assets/grupo.png'),
            ],
          ),
        )
      ],
    );
  }
}
