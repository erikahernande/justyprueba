import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class AlumnoPage extends StatefulWidget {
  late String? idAlumno;

  AlumnoPage({super.key, this.idAlumno});

  @override
  State<AlumnoPage> createState() => _AlumnoPageState();
}

class _AlumnoPageState extends State<AlumnoPage> {
  String titulo = "Registro Alumno";
  String tituloBoton = "Guardar";
  @override
  void initState() {
    // TODO: implement initState
    titulo = widget.idAlumno != null ? "Editar Alumno" : titulo;
    tituloBoton = widget.idAlumno != null ? "Editar" : tituloBoton;
    super.initState();
  }

  String _semestreSele = 'Segundo';

  TextEditingController _numeroControl = TextEditingController();
  TextEditingController _nombre = TextEditingController();

  final List<String> _semestreGrad = [
    'Primer',
    'Segundo',
    'Tercer',
    'Cuarto',
    'Quinto',
    'Sexto'
  ];

  String _groupSele = '6AMPR';
  List<String> _group = ['6AMPR', '6AMRH', '2AMRH'];

  String _espeSele = 'Programación';
  List<String> _espe = [
    'Programación',
    'Recursos Humanos',
    'Electricidad',
    'Ciencia de Datos',
    'Contabilidad'
  ];

  Future _listarGrupos() async {
    try {
      final response =
          await http.post(Uri.parse("http://127.0.0.1/justy/leergrupo.php"));

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

  Future<int> _editarAlumno(String numeroControlOriginal, numeroControlCambio,
      String nombre, String semestre, String grupo, String especialidad) async {
    try {
      final response = await http
          .post(Uri.parse("http://127.0.0.1/justy/editaralumno.php"), body: {
        "numero_control_original": numeroControlOriginal,
        "numero_control": numeroControlCambio,
        "nombre": nombre,
        "semestre": semestre,
        "grupo": grupo,
        "especialidad": especialidad
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

  Future<dynamic> _buscarAlumno(String idAlumno) async {
    try {
      final response = await http.post(
          Uri.parse("http://127.0.0.1/justy/buscaralumno.php"),
          body: {"numero_control": idAlumno});

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
          _crearEditarFormulario(context, widget.idAlumno),
        ],
      ),
    );
  }

  // Widget _editarFormulario()
  // {

  // }

  Widget _formularioAlumno(BuildContext context, AsyncSnapshot? snapshot) {
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
                  _crearNumcontrol(
                      snapshot != null ? snapshot.data[0]["numControl"] : null),
                  SizedBox(
                    height: 20.0,
                  ),
                  _crearNombre(
                      snapshot != null ? snapshot.data[0]["nombre"] : null),
                  SizedBox(
                    height: 20.0,
                  ),
                  _semestre(
                      snapshot != null ? snapshot.data[0]["semestre"] : null),
                  SizedBox(
                    height: 20.0,
                  ),

                  _grupo(
                      snapshot != null ? snapshot.data[0]["grupo_id"] : null),
                  const SizedBox(
                    height: 20.0,
                  ),
                  _especialidad(snapshot != null
                      ? snapshot.data[0]["especialidad"]
                      : null),
                  const SizedBox(
                    height: 30.0,
                  ),
                  _crearBoton(),
                  const SizedBox(
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

  Widget _crearNumcontrol(String? numeroControl) {
    _numeroControl.text = numeroControl ?? "";
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Número de control',
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
          controller: _numeroControl,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
              prefixIcon: const Icon(
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
      ],
    );
  }

  Widget _crearNombre(String? nombre) {
    _nombre.text = nombre ?? "";
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Nombre(s)',
          style: TextStyle(
              color: Color(0xFFFF5B4A42),
              fontSize: 16,
              fontWeight: FontWeight.w500),
          textAlign: TextAlign.end,
        ),
        const SizedBox(
          height: 15,
        ),
        TextFormField(
          controller: _nombre,
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

  List<DropdownMenuItem<String>> getOpcionesDropdown() {
    List<DropdownMenuItem<String>> lista = [];

    _semestreGrad.forEach((opcion) {
      lista.add(DropdownMenuItem(
        child: Text(opcion),
        value: opcion,
      ));
    });

    return lista;
  }

  List<DropdownMenuItem<String>> getOpcionesGrupo(List<dynamic> _grupos) {
    List<DropdownMenuItem<String>> lista2 = [];

    _grupos.forEach((opcion) {
      print(opcion);
      print(opcion["nomenclatura"]);
      lista2.add(DropdownMenuItem(
        child: Text(opcion["nomenclatura"]),
        value: opcion["nomenclatura"],
      ));
    });

    return lista2;

    return lista2;
  }

  List<DropdownMenuItem<String>> getOpcionesEspecialidad() {
    List<DropdownMenuItem<String>> lista4 = [];

    _espe.forEach((opcion3) {
      lista4.add(DropdownMenuItem(
        child: Text(opcion3),
        value: opcion3,
      ));
    });

    return lista4;
  }

  Widget _semestre(String? semestre) {
    _semestreSele = semestre ?? _semestreSele;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Semestre',
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
                  Icons.group,
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
              value: _semestreSele,
              items: getOpcionesDropdown(),
              onChanged: (opt) {
                setState(() {
                  _semestreSele = opt!;
                });
              },
            );
          },
        ),
      ],
    );
  }

  Widget _grupo(String? grupo) {
    return FutureBuilder(
        future: _listarGrupos(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            _groupSele = grupo ?? snapshot.data[0]["nomenclatura"];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'Grupo',
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
                          Icons.group,
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
                      value: _groupSele,
                      items: getOpcionesGrupo(snapshot.data),
                      onChanged: (opt) {
                        setState(() {
                          _groupSele = opt!;
                        });
                      },
                    );
                  },
                ),
              ],
            );
          }
        });
  }

  Widget _especialidad(String? especialidad) {
    _espeSele = especialidad ?? _espeSele;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Especialidad',
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
              value: _espeSele,
              items: getOpcionesEspecialidad(),
              onChanged: (opt) {
                setState(() {
                  _espeSele = opt!;
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
        print("papuuuuuuuuuuu");
        if (widget.idAlumno != null) {
          if (await _editarAlumno(widget.idAlumno!, _numeroControl.text,
                  _nombre.text, _semestreSele, _groupSele, _espeSele) >
              0) {
            widget.idAlumno = _numeroControl.text;
          }
        } else {}
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
          image: DecorationImage(
              image: AssetImage('assets/fondoForm.png'), fit: BoxFit.cover),
          color: Color(0xFFFF6E7D3),
          borderRadius: BorderRadius.circular(50.0)),
    );

    return Stack(
      children: <Widget>[
        fondo,
        Container(
          padding: EdgeInsets.only(top: 7),
          child: Column(
            children: <Widget>[
              Image.asset('assets/fondoAlum.png'),
            ],
          ),
        )
      ],
    );
  }

  Widget _crearEditarFormulario(BuildContext context, String? idAlumno) {
    if (idAlumno != null) {
      return FutureBuilder(
        future: _buscarAlumno(idAlumno),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          print(snapshot.data);
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            return _formularioAlumno(context, snapshot);
          }
        },
      );
    } else {
      return _formularioAlumno(context, null);
    }
  }
}
