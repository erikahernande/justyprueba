import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/fondo.png'), fit: BoxFit.cover),
        ),
        child: Center(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 150),
                alignment: Alignment.center,
                padding: EdgeInsets.all(10.0),
                child: Text('Bienvenido(a)',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 45,
                        fontWeight: FontWeight.bold)),
              ),
              Container(
                  margin: EdgeInsets.only(top: 200),
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10.0),
                  child: ElevatedButton(

                    onPressed: () {
                      Navigator.pushReplacementNamed(context, 'registro');
                    },

                    child: Text(
                      'Crear Cuenta',
                      style: TextStyle(fontSize: 30),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(88, 56, 41, 1),
                      padding: EdgeInsets.only(
                          left: 45, right: 45, top: 15, bottom: 15),
                    ),
                  )),
              Container(
                  margin: EdgeInsets.only(top: 45),
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10.0),
                  child: ElevatedButton(

                    onPressed: () {
                      Navigator.pushReplacementNamed(context, 'login');
                    },

                    child: Text(
                      'Ingresar',
                      style: TextStyle(
                          fontSize: 30, color: Color.fromRGBO(88, 56, 41, 1)),
                    ),
                    style: ElevatedButton.styleFrom(
                      side: BorderSide(
                          width: 2, color: Color.fromRGBO(88, 56, 41, 1)),
                      backgroundColor: Color.fromRGBO(255, 255, 255, 1),
                      padding: EdgeInsets.only(
                          left: 78, right: 78, top: 15, bottom: 15),
                    ),
                  ))
            ],
          ),
        ),
      ),
    ));
  }
}
