import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DocentesPage extends StatefulWidget {
  late String? idDocente;
  DocentesPage({super.key, this.idDocente});

  @override
  State<DocentesPage> createState() => _DocentesPageState();
}

class _DocentesPageState extends State<DocentesPage> {
  String _materiaSele = 'Biología';
  String titulo = "Registro Docente";
  String tituloBoton = "Guardar";
  @override
  void initState() {
    // TODO: implement initState
    titulo = widget.idDocente != null ? "Editar Docente" : titulo;
    tituloBoton = widget.idDocente != null ? "Editar" : tituloBoton;
    super.initState();
  }

  List<String> _materiaGrad = [
    'Biología',
    'Geometría Analitica',
    'Temas de filosofia',
    'Temas de física',
    'Matematicas Aplicadas',
    'Crea páginas web',
    'Física'
  ];

  Future<int> _editarDocente(
      String idDocente, String nombre, String materia) async {
    try {
      final response = await http
          .post(Uri.parse("http://127.0.0.1/justy/editardocente.php"), body: {
        "id_docente": idDocente,
        "nombre": nombre,
        "materia": materia,
      });

      if (response.statusCode == 200) {
        print("vamos los pibes");
        var datauser = json.decode(response.body);
        var mensaje = datauser.toString();

        if (mensaje == "Success") {
          // La consulta fue exitosa
          print("Alumno editado exitoso");
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

  Future<dynamic> _buscarDocente(String idDocente) async {
    try {
      final response = await http.post(
          Uri.parse("http://127.0.0.1/justy/buscardocente.php"),
          body: {"id_docente": idDocente});

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _crearFondo(context),
          _crearEditarFormulario(context, widget.idDocente),
        ],
      ),
    );
  }

  TextEditingController _nombreController = TextEditingController();

  Future<int> _crearDocente(String nombre, String materia) async {
    try {
      final response = await http.post(
          Uri.parse("http://127.0.0.1/justy/agregardocente.php"),
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

  Widget _crearEditarFormulario(BuildContext context, String? idAlumno) {
    if (idAlumno != null) {
      return FutureBuilder(
        future: _buscarDocente(idAlumno),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          print(snapshot.data);
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            return _formularioDocente(context, snapshot);
          }
        },
      );
    } else {
      return _formularioDocente(context, null);
    }
  }

  Widget _formularioDocente(BuildContext context, AsyncSnapshot? snapshot) {
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
                    titulo,
                    style: TextStyle(
                        fontSize: 30.0,
                        color: Color(0xFFFF5B4A42),
                        fontWeight: FontWeight.bold),
                  ),

                  SizedBox(
                    height: 30.0,
                  ),
                  _crearNombre(
                      snapshot != null ? snapshot.data[0]["nombre"] : null),

                  SizedBox(
                    height: 30.0,
                  ),

                  _materia(
                      snapshot != null ? snapshot.data[0]["materia"] : null),

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

  Widget _crearNombre(String? nombre) {
    _nombreController.text = nombre ?? "";
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Nombre(s)',
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
          controller: _nombreController,
          decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.person,
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

  Widget _apellidoUno() {
    return ListTile(
      title: Text(
        'Primer apellido',
        style: TextStyle(
          fontSize: 16,
          color: Color(0xFFFF5B4A42),
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: TextFormField(
        decoration: const InputDecoration(
          prefixIcon: Icon(
            Icons.person,
            color: Colors.black,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
          hintText: '',
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              borderSide: BorderSide(
                color: Color(0xFFFF5B4A42),
                width: 1.5,
              )),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              borderSide: BorderSide(
                color: Color(0xFFFF5B4A42),
                width: 1.5,
              )),
        ),
      ),
    );
  }

  Widget _apellidoDos() {
    return ListTile(
      title: Text(
        'Primer apellido',
        style: TextStyle(
          fontSize: 16,
          color: Color(0xFFFF5B4A42),
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: TextFormField(
        decoration: const InputDecoration(
          prefixIcon: Icon(
            Icons.person,
            color: Colors.black,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
          hintText: '',
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              borderSide: BorderSide(
                color: Color(0xFFFF5B4A42),
                width: 1.5,
              )),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              borderSide: BorderSide(
                color: Color(0xFFFF5B4A42),
                width: 1.5,
              )),
        ),
      ),
    );
  }

  /* List<DropdownMenuItem<String>> getOpcionesDropdown() {
    List<DropdownMenuItem<String>> lista = [];

    _semestreGrad.forEach((poder) {
      lista.add(DropdownMenuItem(
        child: Text(poder),
        value: poder,
      ));
    });

    return lista;
  }*/

  List<DropdownMenuItem<String>> getOpcionesDropdown() {
    List<DropdownMenuItem<String>> lista = [];

    _materiaGrad.forEach((opcion) {
      lista.add(DropdownMenuItem(
        child: Text(opcion),
        value: opcion,
      ));
    });

    return lista;
  }

  Widget _materia(String? materia) {
    _materiaSele = materia ?? _materiaSele;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Materia',
          style: TextStyle(
            color: Color(0xFFFF5B4A42),
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.end,
        ),
        SizedBox(height: 15),
        StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return DropdownButtonFormField(
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
                focusedBorder: borde(),
              ),
              style: TextStyle(color: Colors.black),
              value: _materiaSele,
              items: getOpcionesDropdown(),
              onChanged: (opt) {
                setState(() {
                  _materiaSele = opt!;
                });
              },
            );
          },
        ),
      ],
    );
  }

  Widget _crearBoton() {
    return ElevatedButton(
      // padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),

      child: Text(
        tituloBoton,
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
        if (_nombreController.text.length > 0 && _materiaSele.length > 0) {
          if (widget.idDocente != null) {
            if (await _editarDocente(
                    widget.idDocente!, _nombreController.text, _materiaSele) >
                0) {
              print("Alumno editado exitosamente");
            }
          } else {
            var registro =
                await _crearDocente(_nombreController.text, _materiaSele);
            if (registro > 0) {
              print("piolaaaaaaaaaa");
            }
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
