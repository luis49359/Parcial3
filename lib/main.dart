import 'package:flutter/material.dart';
import 'package:parcial3/paginas/home.dart';


//MARTÍNEZ ROMERO, LUIS GERARDO 25-1930-2018
//RIVERA CARRANZA, CRISTIAN ALEXANDER 25-1703-2018

void main() {
  runApp(const TopAnime());
}

class TopAnime extends StatelessWidget {
  const TopAnime({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: Home());
  }
}
