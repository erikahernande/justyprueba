import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AgregarDocenteGrupo extends StatefulWidget {
  late String idAula;
  AgregarDocenteGrupo({super.key, required this.idAula});

  @override
  State<AgregarDocenteGrupo> createState() => _AgregarDocenteState();
}

class _AgregarDocenteState extends State<AgregarDocenteGrupo> {
  String _docenteSelec = "";

  Future<int> _crearGrupoDoc(String grupo_id, String docente_id) async {
    try {
      final response = await http.post(
          Uri.parse("http://127.0.0.1/justy/agregargrupodocente.php"),
          body: {"grupo_id": grupo_id, "docente_id": docente_id});

      if (response.statusCode == 200) {
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
      }
    } catch (e) {
      print("ufff, entró en el catch");
      print(e);
      return 0;
    }
    return 0;
  }

  Future _listarDocentes() async {
    try {
      final response =
          await http.post(Uri.parse("http://127.0.0.1/justy/leerdocente.php"));

      if (response.statusCode == 200) {
        var datauser = jsonDecode(response.body);
        var mensaje = datauser.toString();

        if (mensaje.length > 0) {
          // La consulta fue exitosa
          return datauser;
        }
      }
    } catch (e) {
      print("ufff, entró en el catch");
      print(e);
      return [];
    }
    return [];
  }

  String _materiaSele = 'Biología';

  List<String> _materiaGrad = [
    'Biología',
    'Geometría Analitica',
    'Temas de filosofia',
    'Temas de física',
    'Matematicas Aplicadas',
    'Crea páginas web'
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

  TextEditingController _nombreController = TextEditingController();

  Future<int> _crearDocente(String nombre, String materia) async {
    try {
      final response = await http.post(
          Uri.parse("http://127.0.0.1/justy/leerdocente.php"),
          body: {"username": nombre, "password": materia});

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
                    'Añadir nuevo docente',
                    style: TextStyle(
                        fontSize: 30.0,
                        color: Color(0xFFFF5B4A42),
                        fontWeight: FontWeight.bold),
                  ),

                  SizedBox(
                    height: 30.0,
                  ),

                  _docente(),

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

  List<DropdownMenuItem<String>> getOpcionesDropdown(List<dynamic> _docentes) {
    List<DropdownMenuItem<String>> lista = [];
    // _materiaGrad.forEach((opcion) {
    //   lista.add(DropdownMenuItem(
    //     child: Text(opcion),
    //     value: opcion,
    //   ));
    // });

    _docentes.forEach((opcion) {
      print(opcion);
      print(opcion["nomenclatura"]);
      lista.add(DropdownMenuItem(
        child: Text(opcion["nombre"]),
        value: opcion["idDoc"],
      ));
    });

    return lista;
  }

  Widget _docente() {
    return FutureBuilder(
      future: _listarDocentes(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else {
          _docenteSelec = snapshot.data[0]["idDoc"];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Seleccione un docente',
                style: TextStyle(
                    color: Color(0xFFFF5B4A42),
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
                textAlign: TextAlign.end,
              ),
              SizedBox(
                height: 15,
              ),
              DropdownButtonFormField(
                decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.book,
                      color: Colors.black,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    hintText: '',
                    enabledBorder: borde(),
                    focusedBorder: borde()),
                style: TextStyle(color: const Color.fromARGB(255, 38, 33, 33)),
                value: _docenteSelec,
                items: getOpcionesDropdown(snapshot.data),
                onChanged: (opt) {
                  setState(() {
                    _docenteSelec = opt!;
                  });
                },
              ),
            ],
          );
        }
      },
    );
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
        var registro = await _crearGrupoDoc(widget.idAula, _docenteSelec);
        if (registro > 0) {
          print("piolaaaaaaaaaa");
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
          // image: DecorationImage(
          //    image: AssetImage('assets/fondo.png'), fit: BoxFit.cover),
          color: Color(0xFFFF6E7D3),
          borderRadius: BorderRadius.circular(50.0)),
    );

    return Stack(
      children: <Widget>[
        fondo,
        Container(
          padding: EdgeInsets.only(top: 15),
          child: Column(
            children: <Widget>[
              Image.asset('assets/docente.png'),
            ],
          ),
        )
      ],
    );
  }
}
