import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Album {
  final int userId;
  final int id;
  final String title;

  Album({@required this.userId, @required this.id, @required this.title});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(userId: json['userId'], id: json['id'], title: json['title']);
  }
}

//GET - Consulta
Future<Album> fetchAlbum() async {
  final resposta =
      await http.get(Uri.https('jsonplaceholder.typicode.com', 'albums/1'));

  if (resposta.statusCode == 200) {
    return Album.fromJson(jsonDecode(resposta.body));
  } else {
    throw Exception('Falha no carregamento do album');
  }
}

//POST
Future<Album> createAlbum(String title) async {
  final response = await http.post(
    Uri.https('jsonplaceholder.typicode.com', 'albums'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8'
    },
    body: jsonEncode(<String, String>{
      'title': title,
    }),
  );

  if (response.statusCode == 201) {
    return Album.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Fala]ha ao criar um Album.');
  }
}
