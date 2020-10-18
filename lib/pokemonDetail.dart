import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'model/pokedex.dart';
import 'package:palette_generator/palette_generator.dart';

class PokemonDetail extends StatefulWidget {
  Pokemon pokemon;


  PokemonDetail({this.pokemon});

  @override
  PokemonDetailState createState() => PokemonDetailState();
}

class PokemonDetailState extends State<PokemonDetail> {
  PaletteGenerator paletteGenerator;
  Color baskinRenk;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    baskinRengiBul();
  }
  void baskinRengiBul() {
    Future<PaletteGenerator> fPaletGenerator =
    PaletteGenerator.fromImageProvider(
        NetworkImage(widget.pokemon.img));
        fPaletGenerator.then((value) {
      paletteGenerator = value;
      debugPrint(
          "secilen renk :" + paletteGenerator.dominantColor.color.toString());

      setState(() {
        baskinRenk = paletteGenerator.dominantColor.color;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:baskinRenk,
      appBar: AppBar(
        title: Text(
          widget.pokemon.name,
          textAlign: TextAlign.center,
        ),
        elevation: 0,
      ),
      body: OrientationBuilder(builder: (context,oriantation){
        if(oriantation==Orientation.portrait) return DikeyBody(context);
        else return YatayBody(context);
      }),
    );
  }

  Stack DikeyBody(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          height: MediaQuery.of(context).size.height * (7 / 10),
          width: MediaQuery.of(context).size.width - 20,
          left: 10,
          top: MediaQuery.of(context).size.height * 0.1,
          child: Card(
            elevation: 6,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SizedBox(
                  height: 60,
                ),
                Text(
                  widget.pokemon.name,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Height :" + widget.pokemon.height,
                ),
                Text(
                  "Weight :" + widget.pokemon.weight,
                ),
                Text(
                  "Types :",
                  style: TextStyle( fontWeight: FontWeight.bold),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: widget.pokemon.type
                        .map((tip) => Chip(
                            backgroundColor: ChipRenkSec(tip),
                            label: Text(tip)))
                        .toList()),
                Text(
                  "Pre Evolution :",
                  style: TextStyle( fontWeight: FontWeight.bold),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: widget.pokemon.prevEvolution != null
                        ? widget.pokemon.prevEvolution
                        .map((evolution) =>
                        Chip(backgroundColor:baskinRenk,label: Text(evolution.name)))
                        .toList()
                        : [Text("First Form")]),
                Text(
                  "Next Evolution :",
                  style: TextStyle( fontWeight: FontWeight.bold),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: widget.pokemon.nextEvolution != null
                        ? widget.pokemon.nextEvolution
                            .map((evolution) =>
                                Chip(backgroundColor:baskinRenk,label: Text(evolution.name)))
                            .toList()
                        : [Text("Final Form")]),
                Text(
                  "Weakness :",
                  style: TextStyle( fontWeight: FontWeight.bold),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: widget.pokemon.weaknesses != null
                        ? widget.pokemon.weaknesses
                        .map((weakness) =>
                        Chip(backgroundColor:ChipRenkSec(weakness),label: Text(weakness)))
                        .toList()
                        : [Text("Has no weakness")]),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Hero(
              tag: widget.pokemon.img,
              child: Container(
                width: 150,
                height: 150,
                child: Image.network(
                  widget.pokemon.img,
                  fit: BoxFit.contain,
                ),
              )),
        )
      ],
    );
  }

  Widget YatayBody(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width-30,
      height: MediaQuery.of(context).size.height*(3/4),
      margin: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(border: Border.all(color: Colors.white),borderRadius: BorderRadius.circular(15),   color: Colors.white, ),

      child: Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,children: <Widget>[
        Expanded(flex: 2,child:Hero(
            tag: widget.pokemon.img,
            child: Container(
              width: 150,
              height: 150,
              child: Image.network(
                widget.pokemon.img,
                fit: BoxFit.contain,
              ),
            ))),
        Expanded(child:
        SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                widget.pokemon.name,
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              Text(
                "Height :" + widget.pokemon.height,
              ),
              Text(
                "Weight :" + widget.pokemon.weight,
              ),
              Text(
                "Types :",
                style: TextStyle( fontWeight: FontWeight.bold),
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: widget.pokemon.type
                      .map((tip) => Chip(
                      backgroundColor: ChipRenkSec(tip),
                      label: Text(tip)))
                      .toList()),
              Text(
                "Pre Evolution :",
                style: TextStyle( fontWeight: FontWeight.bold),
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: widget.pokemon.prevEvolution != null
                      ? widget.pokemon.prevEvolution
                      .map((evolution) =>
                      Chip(label: Text(evolution.name)))
                      .toList()
                      : [Text("First Form")]),
              Text(
                "Next Evolution :",
                style: TextStyle( fontWeight: FontWeight.bold),
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: widget.pokemon.nextEvolution != null
                      ? widget.pokemon.nextEvolution
                      .map((evolution) =>
                      Chip(label: Text(evolution.name)))
                      .toList()
                      : [Text("Final Form")]),
              Text(
                "Weakness :",
                style: TextStyle( fontWeight: FontWeight.bold),
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: widget.pokemon.weaknesses != null
                      ? widget.pokemon.weaknesses
                      .map((weakness) =>
                      Chip(backgroundColor:ChipRenkSec(weakness),label: Text(weakness)))
                      .toList()
                      : [Text("Has no weakness")]),
            ],
          ),
        ),flex:4 ,)
      ],),
    );
  }

  Color ChipRenkSec(String tip) {
    if (tip == "Grass") return Colors.greenAccent;
    if (tip == "Poison") return Colors.purpleAccent;
    if (tip == "Fire") return Colors.deepOrangeAccent;
    if (tip == "Ice") return Colors.cyanAccent;
    if (tip == "Flying") return Colors.blueGrey;
    if (tip == "Psychic") return Colors.deepPurpleAccent;
    if (tip == "Normal") return Colors.grey;
    if (tip == "Electric") return Colors.yellowAccent;
    if (tip == "Rock") return Colors.brown;
    if (tip == "Water") return Colors.blueAccent;
    if (tip == "Fighting") return Colors.brown[500];
    if (tip == "Fairy") return Colors.pinkAccent;
    if (tip == "Bug") return Colors.lightGreenAccent;

    else return Colors.white;
  }
}
