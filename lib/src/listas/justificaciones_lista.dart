import 'package:flutter/material.dart';

class JustificacionesLista extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [
            _appBar(context),
            Expanded(child: _lista(context)),
          ]
        ),
        floatingActionButton: _botonAgregar(context),
      );
  }

  Widget _appBar(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final buscador = Container(
      margin: EdgeInsets.only(
        top: size.height*0.12,
        left: size.width*0.08
      ),
      width: size.width*0.85,
      child: TextField(
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(35),
            borderSide: BorderSide.none
          ),
          hintText: 'Buscar alumno',
          suffixIcon: Icon(Icons.search),
          suffixIconColor: Color.fromRGBO(91, 74, 66, 1)
        ),
      ),
    );

    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            color: Color.fromRGBO(246, 231, 211, 1),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(40),
              bottomRight: Radius.circular(40)
            )
          ),
          width: size.width,
          height: size.height*0.23,
        ),
        Container(
          margin: EdgeInsets.only(top: 40),
          child: IconButton(
            icon: Icon(Icons.arrow_back_rounded),
            iconSize: 40,
            color: Color.fromRGBO(91, 74, 66, 1),
            onPressed: (){
              Navigator.pop(context);
            },
          )
        ),
        buscador,
      ]
    );
  }

  Widget _lista(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: size.width*0.07),
        children: [
          _campoUsuario(context, 'Lizbeth Uh Mazún'),
          _campoUsuario(context, 'Noé Solís May'),
          _campoUsuario(context, 'Casimiro Uuh Echeverria'),
          _campoUsuario(context, 'Belinda Muñoz'),   
          _campoUsuario(context, 'Raúl Ortiz León'),
          _campoUsuario(context, 'Renén Canul Almaraz'),
          _campoUsuario(context, 'Raúl Ortiz Esquivel'),
          _campoUsuario(context, 'Juanito Jesús'),
          _campoUsuario(context, 'Beatriz Moo'),
          _campoUsuario(context, 'Santiago Esquivel')
        ],
      );
  }

  Widget _campoUsuario(BuildContext context, String nombre) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 15),
        width: size.width*0.8,
        height: 60,
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: Color.fromRGBO(184, 135, 109, 1),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [BoxShadow(
            color: Colors.black45.withOpacity(0.19),
            offset: Offset(0, 10),
            blurRadius: 4
          )],
          border: Border.all(color: Color.fromRGBO(149, 102, 77, 1), width: 1.5)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(Icons.person, color: Colors.white, size: 40,),
            Text(nombre, style: TextStyle(color: Colors.white, fontSize: 18)),
            Text('Ver perfil', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16))  
          ],
        ),
      ),
      onTap: (){
        print('navegando a otra pagina');
      },
    );
  }

  Widget _botonAgregar(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return FloatingActionButton(
      backgroundColor: Color.fromRGBO(91, 74, 66, 1),
      child: Icon(Icons.add, size: 40),
      onPressed: (){
         Navigator.pushNamed(context, 'formalumnos');
      }
    );
  }
}