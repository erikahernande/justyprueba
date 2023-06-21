import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:google_sign_in/google_sign_in.dart';

class JustificacionPage extends StatefulWidget {
  @override
  State<JustificacionPage> createState() => _JustificacionPageState();
}

class _JustificacionPageState extends State<JustificacionPage> {
  String _espeSele = 'Programacion';
  List<String> _espeGrad = [
    'Primer',
    'Programacion',
    'Tercer',
    'Cuarto',
    'Quinto',
    'Sexto'
  ];

  Future<void> sendEmail() async {
    try {
      var userEmail = 'kumulsaul@gmail.com';
      var mensaje = Message();
      mensaje.subject = "Enviado de Flutter papu";
      mensaje.text = "Hola papuuuuuuuuuuuuuuuu";
      mensaje.from = Address(userEmail.toString());
      mensaje.recipients.add(userEmail);
      //var smtpServer = gmailSaslXoauth2(userEmail, "htargdhrkmtwnjtn");
      var smtp = gmailRelaySaslXoauth2(userEmail, "htargdhrkmtwnjtn");
      send(mensaje, smtp);
      print('Email enviado correctanmente');
    } catch (e) {
      print(e);
      print("Hubo un error al enviar el Email");
    }
  }

  Future<int> _crearDocente(String nombre, String materia) async {
    try {
      final response = await http.post(
          Uri.parse("http://127.0.0.1/justy/agregargrup.php"),
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

  //String _grupSele = '6AMR';
  List<String> _grupGrad = [
    'Primer',
    'Programacion',
    'Tercer',
    'Cuarto',
    'Quinto',
    'Sexto'
  ];
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
                  'Crear justificación',
                  style: TextStyle(
                      fontSize: 30.0,
                      color: Color(0xFFFF5B4A42),
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10.0,
                ),
                _grupo(),
                SizedBox(
                  height: 10.0,
                ),

                Row(
                  children: <Widget>[
                    Expanded(child: _fechaInicio()),
                    Expanded(child: _fechaFinal())
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(child: _horaInicio()),
                    Expanded(child: _horaFinal())
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                _motivo(),
                SizedBox(
                  height: 10.0,
                ),
                _otroMotivo(),
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

  List<DropdownMenuItem<String>> getOpcionesDropdown() {
    List<DropdownMenuItem<String>> lista = [];

    _espeGrad.forEach((opcion) {
      lista.add(DropdownMenuItem(
        child: Text(opcion),
        value: opcion,
      ));
    });

    return lista;
  }

  List<DropdownMenuItem<String>> getOpcionesGrup() {
    List<DropdownMenuItem<String>> lista = [];

    _grupGrad.forEach((opcion) {
      lista.add(DropdownMenuItem(
        child: Text(opcion),
        value: opcion,
      ));
    });

    return lista;
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
          value: _espeSele,
          items: getOpcionesDropdown(),
          onChanged: (opt) {
            setState(() {
              _espeSele = opt!;
            });
          },
        ),
      ],
    );
  }

  Widget _fechaInicio() {
    return ListTile(
      title: Text(
        'Fecha inicio',
        style: TextStyle(
          fontSize: 16,
          color: Color(0xFFFF5B4A42),
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: TextFormField(
        decoration: const InputDecoration(
          prefixIcon: Icon(
            Icons.calendar_month,
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

  Widget _fechaFinal() {
    return ListTile(
      title: Text(
        'Fecha final',
        style: TextStyle(
          fontSize: 16,
          color: Color(0xFFFF5B4A42),
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: TextFormField(
        decoration: const InputDecoration(
          prefixIcon: Icon(
            Icons.calendar_month,
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

  Widget _horaInicio() {
    return ListTile(
      title: Text(
        'Hora inicio',
        style: TextStyle(
          fontSize: 16,
          color: Color(0xFFFF5B4A42),
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: TextFormField(
        decoration: const InputDecoration(
          prefixIcon: Icon(
            Icons.timer_outlined,
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

  Widget _horaFinal() {
    return ListTile(
      title: Text(
        'Hora final',
        style: TextStyle(
          fontSize: 16,
          color: Color(0xFFFF5B4A42),
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: TextFormField(
        decoration: const InputDecoration(
          prefixIcon: Icon(
            Icons.timer_outlined,
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

  Widget _motivo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Motivo',
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
          value: _espeSele,
          items: getOpcionesDropdown(),
          onChanged: (opt) {
            setState(() {
              _espeSele = opt!;
            });
          },
        ),
      ],
    );
  }

  Widget _otroMotivo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Otro motivo',
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
        await sendEmail();
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
              image: AssetImage('assets/fondo.png'), fit: BoxFit.cover),
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
              Image.asset('assets/justificaciones.png'),
            ],
          ),
        )
      ],
    );
  }
}
