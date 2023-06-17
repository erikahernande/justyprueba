import 'package:flutter/material.dart';

class EditarAlumno extends StatefulWidget {
  @override
  State<EditarAlumno> createState() => _EditarAlumnoState();
}

class _EditarAlumnoState extends State<EditarAlumno> {
  String _semestreSele = 'Segundo';

  List<String> _semestreGrad = [
    'Primer',
    'Segundo',
    'Tercer',
    'Cuarto',
    'Quinto',
    'Sexto'
  ];

  /*String _groupSele = '6AMPR';

  List<String> _group = ['6AMPR', '2AMRH', '2AMRH', '2AMRH', '2AMRH', '2AMRH'];
  String _turnSele = 'Matutino';

  List<String> _turn = ['Matutino', 'Vespertino'];*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _crearFondo(context),
          _crearFormulario(context),
        ],
      ),
    );
  }

  Widget _crearFormulario(BuildContext context) {
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
            child: Column(
              children: <Widget>[
                Text(
                  'Editar datos',
                  style: TextStyle(
                      fontSize: 30.0,
                      color: Color(0xFFFF5B4A42),
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 30.0,
                ),
                _crearNumcontrol(),
                SizedBox(
                  height: 20.0,
                ),
                _crearNombre(),
                SizedBox(
                  height: 20.0,
                ),

                Row(
                  children: <Widget>[
                    Expanded(
                      child: _apellidoUno(),
                    ),
                    Expanded(child: _apellidoDos())
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),

                _telefono(),
                SizedBox(
                  height: 20.0,
                ),

                _semestre(),
                SizedBox(
                  height: 20.0,
                ),

                _grupo(),

                SizedBox(
                  width: 30,
                ),
                _turno(),

                SizedBox(
                  height: 20.0,
                ),
                _especialidad(),
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
        ],
      ),
    );
  }

  Widget _crearNumcontrol() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
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
      ],
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
    return Container(
      child: ListTile(
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

  Widget _telefono() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Teléfono',
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
                Icons.phone,
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

  Widget _semestre() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Semestre',
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
                Icons.group,
                color: Colors.black,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              hintText: '',
              enabledBorder: borde(),
              focusedBorder: borde()),
          style: TextStyle(color: Colors.black),
          value: _semestreSele,
          items: getOpcionesDropdown(),
          onChanged: (opt) {
            setState(() {
              _semestreSele = opt!;
            });
          },
        ),
      ],
    );
  }

  Widget _grupo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Grupo',
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
                Icons.group,
                color: Colors.black,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              hintText: '',
              enabledBorder: borde(),
              focusedBorder: borde()),
          style: TextStyle(color: Colors.black),
          value: _semestreSele,
          items: getOpcionesDropdown(),
          onChanged: (opt) {
            setState(() {
              _semestreSele = opt!;
            });
          },
        ),
      ],
    );
  }

  Widget _turno() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 15,
        ),
        Text(
          'Turno',
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
                Icons.settings_display,
                color: Colors.black,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              hintText: '',
              enabledBorder: borde(),
              focusedBorder: borde()),
          style: TextStyle(color: Colors.black),
          value: _semestreSele,
          items: getOpcionesDropdown(),
          onChanged: (opt) {
            setState(() {
              _semestreSele = opt!;
            });
          },
        ),
      ],
    );
  }

  Widget _especialidad() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Especialidad',
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
          value: _semestreSele,
          items: getOpcionesDropdown(),
          onChanged: (opt) {
            setState(() {
              _semestreSele = opt!;
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
}
