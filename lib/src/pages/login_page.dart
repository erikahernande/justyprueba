import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class LoginPage extends StatelessWidget {
  String mensaje = "";

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/backgroungIni.png'),
              fit: BoxFit.cover)),
      child: Center(
        child: _loginForm(context),
      ),
    ));
  }
}

Future<int> _login() async {
  try {
    final response = await http.post(
        Uri.parse("http://127.0.0.1/justy/login.php"),
        body: {"username": "Mariana", "password": "1234"});

    if (response.statusCode == 200) {
      print("vamos los pibes");
      var datauser = json.decode(response.body);
      var mensaje = datauser.toString();

      if (mensaje == "Success papuuuuuu") {
        // La consulta fue exitosa
        print("Inicio de sesión exitoso");
        return 1;
      } else {
        // La consulta no fue exitosa
        print("Error en el inicio de sesión");
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

Widget _loginForm(BuildContext context) {
  final size = MediaQuery.of(context).size;
  return SingleChildScrollView(
    child: Column(
      children: <Widget>[
        SafeArea(
          child: Container(
            height: 40.0,
          ),
        ),
        Container(
          width: size.width * 0.85,
          margin: EdgeInsets.symmetric(vertical: 30.0),
          padding: EdgeInsets.symmetric(vertical: 50.0),
          child: Column(
            children: <Widget>[
              Text('Ingresarrr',
                  style: TextStyle(
                    fontSize: 45.0,
                    color: Color.fromRGBO(91, 74, 66, 1),
                  )),
              SizedBox(height: 120.0),
              _labelCuenta(),
              SizedBox(height: 10.0),
              _crearEmail(),
              SizedBox(height: 30.0),
              _labelContra(),
              SizedBox(height: 10.0),
              _crearPassword(),
              SizedBox(height: 30.0),
              TextButton(
                  onPressed: () =>
                      Navigator.pushReplacementNamed(context, 'registro'),
                  child: Text(
                    '¿Aún no tienes una cuenta?, Créssalo Aquí',
                    style: TextStyle(color: Color.fromRGBO(91, 74, 66, 1)),
                  )),
              SizedBox(height: 6.0),
              SizedBox(height: 10.0),
              _crearBoton(context)
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _labelCuenta() {
  return Padding(
    padding: const EdgeInsets.only(left: 11),
    child: Row(
      children: [
        Text(
          'Correo electronico',
          style: TextStyle(color: Color.fromRGBO(91, 74, 66, 1)),
          textAlign: TextAlign.start,
        ),
      ],
    ),
  );
}

Widget _labelContra() {
  return Padding(
    padding: const EdgeInsets.only(left: 11),
    child: Row(
      children: [
        Text(
          'Contraseña',
          style: TextStyle(color: Color.fromRGBO(91, 74, 66, 1)),
          textAlign: TextAlign.start,
        ),
      ],
    ),
  );
}

Widget _crearEmail() {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 20.0),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        border: Border.all(color: Colors.grey),
        color: Colors.white,
        boxShadow: const <BoxShadow>[
          BoxShadow(
              color: Colors.black45, //numeros el indice de opacidad
              blurRadius: 2.0,
              spreadRadius: 1.0,
              offset: Offset(2.0, 5.0) //posicion de la sombra
              )
        ]),
    child: TextField(
      keyboardType: TextInputType.emailAddress,

      decoration: InputDecoration(
        hintText: 'ejemplo@correo.com',
        border: InputBorder.none,
        //labelText: 'Correo electrónico',
        //counterText: snapshot.data,
        //errorText: snapshot.error
      ),
      //onChanged: bloc.changeEmail,
    ),
  );
}

Widget _crearPassword() {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 20.0),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        border: Border.all(color: Colors.grey),
        color: Colors.white,
        boxShadow: const <BoxShadow>[
          BoxShadow(
              color: Colors.black45, //numeros el indice de opacidad
              blurRadius: 2.0,
              spreadRadius: 1.0,
              offset: Offset(2.0, 5.0) //posicion de la sombra
              )
        ]),
    child: TextField(
      obscureText: true,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: 'Contraseña',
        //counterText: snapshot.data,
        //errorText: snapshot.error
      ),
      //onChanged: bloc.changePassword,
    ),
  );
}

Widget _crearBoton(context) {
  //formValidStream
  // snapshot.hasData
  //  true ? algo si true : algo si false

  return ElevatedButton(
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
      child: Text('Ingresar'),
    ),
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      backgroundColor: Color.fromRGBO(184, 135, 109, 1),
    ),

    // shape: RoundedRectangleBorder(
    //   borderRadius: BorderRadius.circular(5.0)
    // ),
    // elevation: 0.0,
    // color: Colors.deepPurple,
    // textColor: Colors.white,
    //onPressed: snapshot.hasData ? ()=> _login(bloc, context) : null
    onPressed: () async {
      var inicio = await _login();
      if (inicio == 1) {
        Navigator.pushNamed(context, 'inicio');
      } else {
        print("no papuuuuuuu");
      }
    },
  );
}
