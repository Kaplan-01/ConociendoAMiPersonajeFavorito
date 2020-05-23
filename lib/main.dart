import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:just_audio/just_audio.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/audio_cache.dart';
import 'dart:developer';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'pageNew.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme:
      ThemeData(
          brightness: Brightness.dark, primarySwatch: Colors.red),
      darkTheme: ThemeData(
          brightness: Brightness.light, primarySwatch: Colors.pink),
      home: homePage(),
    );
  }
}

class homePage extends StatefulWidget {
  @override
  _myHomePageState createState() => new _myHomePageState();
}

class _myHomePageState extends State<homePage>{
  // Metodo asincrono para leer el JSON

  Future<String> _loadAsset() async{
    return await rootBundle.loadString('assets/Personajes1.1.json');
  }

  Future<List<heroes>> _getHeroes() async{
    String jsonString = await _loadAsset();
    var jsonData = json.decode(jsonString);
    print(jsonData.toString());

    List<heroes> heros =[];
    for(var h in jsonData){
      heroes he =  heroes(h["nombre"], h["edad"],  h["altura"],  h["genero"],  h["profile"], h["identidad"], h["poder"],  h["combate"],  h["superpoder"],  h["descripcion"]);
      heros.add(he);
    }

    print("Numeros de elemento: ");
    print(heros.length);
    return heros;
  }

  // Var
  bool _typing = false;
  String _searchText="";
  final TextEditingController _search = new TextEditingController();


  // Music Background
  AudioPlayer audioPlayer;
  AudioCache audioCache;
  final musicB = "Electricity.mp3";

  @override
  void initState(){
    super.initState();
    audioCache = AudioCache();
    audioPlayer = AudioPlayer();
    setState(() {
      audioCache.play(musicB);
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: _typing ? TextField(
          autofocus: true,
          controller: _search,
          onChanged: (text){
            setState(() {
            _searchText = text;
            });
          }
        ):Text("Busca tu personaje "),
        leading: IconButton(
          highlightColor: Colors.lightGreen,
          padding: EdgeInsets.all(10),
          icon: Icon(_typing ? Icons.done: Icons.search),
          onPressed: (){
            print("Escribiendo... "+_typing.toString());
            setState(() {
              _typing = ! _typing;
              _search.text="";
              print(_search);
            });
          },
        ),

        backgroundColor: Colors.pink,
        centerTitle: true,
      ),


      body:  Container(
        child: FutureBuilder(
          future: _getHeroes(),
          builder: (BuildContext context, AsyncSnapshot snapshot){
            if(snapshot.data == null){
              return Container(
                child: Center(
                  child: Text("Cargando..."),
                ),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    print("Date Value: $snapshot.data[index].profile.toString()");
                    return snapshot.data[index].nombre.toLowerCase().contains(_search.text.toLowerCase()) ?
                      ListTile(
                        leading:
                        CircleAvatar(
                          maxRadius: 30,
                          minRadius: 30,
                          backgroundImage: NetworkImage(snapshot.data[index]
                              .profile.toString()),
                        ),
                        title: new Text(snapshot.data[index].nombre.toString()),
                        subtitle: new Text(snapshot.data[index].edad.toString()),
                        onTap: () {
                          Navigator.push(context, new MaterialPageRoute(
                              builder: (context) =>
                                  DetailPage(snapshot.data[index])));
                      },
                   ): Container();
                }
              );
            }
          },
        ),
      ),
    );
  }
}





