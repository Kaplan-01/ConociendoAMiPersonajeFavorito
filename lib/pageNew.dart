import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:developer';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'main.dart';

class DetailPage1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.deepOrange,
        ),
        body: DetailPage1(),
      ),
    );
  }
}

class heroes {
  final String nombre;
  final String identidad;
  final String edad;
  final String altura;
  final String genero;
  final String profile;
  final String poder;
  final String combate;
  final String superpoder;
  final String descripcion;

  heroes(this.nombre, this.edad, this.altura, this.genero, this.profile, this.identidad, this.poder, this.combate, this.superpoder, this.descripcion);

}

class DetailPage extends StatelessWidget{
  final heroes hero;
  DetailPage(this.hero);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(hero.nombre.toString()),
      ),

      body: new Container(
        child: new Center(
          child: new FutureBuilder(
            future: DefaultAssetBundle.of(context).loadString('assets/Personajes1.1.json'),
            builder: (context,snapshot){
              var jsonData = json.decode(snapshot.data.toString());
                  return SingleChildScrollView(
                    child: SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 14, right: 14, top: 5),
                        child: new Card(
                          color: Colors.indigoAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),

                          child: Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: new Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(top: 13, right: 15, left: 15, bottom: 10),
                                  child: Center(
                                    child: CircleAvatar(
                                        maxRadius: 160,
                                        minRadius: 160,
                                        backgroundImage: NetworkImage(hero.profile.toString()),
                                      ),
                                  ),
                                ),

                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: new Text("Nombre superheroe: "+hero.nombre.toString()),
                                ),

                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: new Text("Identidad secreta: "+hero.identidad.toString()),
                                ),

                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: new Text("Edad: "+hero.edad.toString()),
                                ),

                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: new Text("Altura: "+hero.altura.toString()),
                                ),

                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: new Text("Sexo: "+hero.genero.toString()),
                                ),

                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: new Text("Poder: "+hero.poder.toString()),
                                ),

                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: new Text("Fuerza en combate: "+hero.combate.toString()),
                                ),

                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: new Text("Superpoder: "+hero.superpoder.toString()),
                                ),

                                Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: new Text("\nDescripcion: \n"+hero.descripcion.toString()),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
             ),
           ),
         ),
       );
    }
}

