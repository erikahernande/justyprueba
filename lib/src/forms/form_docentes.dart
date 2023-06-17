import 'package:flutter/material.dart';

class DocentesPage extends StatefulWidget {
  @override
  State<DocentesPage> createState() => _DocentesPageState();
}

class _DocentesPageState extends State<DocentesPage> {
  
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
                    'Registro de docentes',
                    style: TextStyle(
                        fontSize: 30.0,
                        color: Color(0xFFFF5B4A42),
                        fontWeight: FontWeight.bold),
                  ),
          
                  SizedBox(
                    height: 30.0,
                  ),
                  _crearNombre(),
                  
                  
                   SizedBox(
                    height: 30.0,
                  ),
          
                  _materia(),
          
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

  Widget _crearNombre() {
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

  Widget _materia() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Materia',
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
          style: TextStyle(color: Colors.black),
          value: _materiaSele,
          items: getOpcionesDropdown(),
          onChanged: (opt) {
            setState(() {
              _materiaSele = opt!;
            });
          },
        ),
      ],
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
      onPressed: () {},
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
