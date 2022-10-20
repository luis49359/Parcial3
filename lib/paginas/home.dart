import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';

import 'detalleanime.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List listaAnime = [];
  @override
  Widget build(BuildContext context) {
    var ancho = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 60,
        title: Center(
          child: Container(
            height: 50,
            width: ancho * 0.3,
            decoration: BoxDecoration(
                image: const DecorationImage(
                    image: AssetImage("assets/img/icon.png"),
                    fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(10)),
          ),
        )),
        body: Stack(
          children: [
            const Positioned(
              top: 0,
              left: 20,
              child: Text(
                "TOP ANIME",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            Positioned(
              top: 45,
              bottom: 0,
              width: ancho,
              child: Column(children: [
                SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(color: Colors.white)),
                      child: Padding(
                          padding: const EdgeInsets.only(left: 20, top: 20),
                          child: GestureDetector(
                              child: Column(
                            children: [
                              SizedBox(
                                width: ancho * 0.4,
                                height: 40,
                                child: const Text(
                                  "MARTINEZ ROMERO, LUIS GERARDO",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              SizedBox(
                                width: ancho * 0.4,
                                height: 30,
                                child: const Text(
                                  "25-1930-2018",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ))),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 25),
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(color: Colors.white)),
                        child: Padding(
                            padding: const EdgeInsets.only(left: 20, top: 20),
                            child: GestureDetector(
                                child: Column(
                              children: [
                                SizedBox(
                                  width: ancho * 0.4,
                                  height: 40,
                                  child: const Text(
                                    "RIVERA CARRANZA, CRISTIAN ALEXANDER",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                SizedBox(
                                  width: ancho * 0.4,
                                  height: 30,
                                  child: const Text(
                                    "25-1703-2018",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ))),
                      ),
                    )
                  ],
                ),
              ),
                // ignore: unnecessary_null_comparison
                listaAnime.length != null
                    ? Expanded(
                        child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2, childAspectRatio: 0.5),
                        itemCount: listaAnime.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 4.0, horizontal: 8),
                              child: Container(
                                  // ignore: prefer_const_constructors
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(20))),
                                  child: Stack(children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 20, left: 20, top: 7),
                                      child: SizedBox(
                                          child: Text(
                                        "Puesto ${listaAnime[index]['rank']}°",
                                        textAlign: TextAlign.center,
                                        // ignore: prefer_const_constructors
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                            color: listaAnime[index]['rank'] ==
                                                    1
                                                ? Colors.amber[400]
                                                : listaAnime[index]['rank'] == 2
                                                    ? Colors.blueGrey[300]
                                                    : listaAnime[index]
                                                                ['rank'] ==
                                                            3
                                                        ? Colors.brown
                                                        : Colors.black),
                                      )),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 20, left: 20, top: 25),
                                      child: SizedBox(
                                          child: Text(
                                        listaAnime[index]['title'],
                                        maxLines: 2,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                          color: Colors.black,
                                        ),
                                      )),
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      right: 0,
                                      child: CachedNetworkImage(
                                        imageUrl: listaAnime[index]['images']
                                            ['jpg']['image_url'],
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ])),
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => DetalleAnime(
                                          animeDetalle: listaAnime[index])));
                            },
                          );
                        },
                      ))
                    : const Center(
                        child: CircularProgressIndicator(),
                      )
              ]),
            ),
          ],
        ));
  }

  @override
  void initState() {
    super.initState();
    if (mounted) {
      datosAnime();
    }
  }

  void datosAnime() {
    var url = Uri.https('api.jikan.moe', '/v4/top/anime', {'limit': '20'});
    http.get(url).then((value) {
      if (value.statusCode == 200) {
        var decodejsonData = jsonDecode(value.body);
        listaAnime = decodejsonData['data'];
        setState(() {});
      }
    });
  }
}

