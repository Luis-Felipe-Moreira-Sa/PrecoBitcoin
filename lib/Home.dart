import 'dart:html';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _preco = "";
  String _preco_2 = "";
  Future<Map<String, dynamic>> requestUrl() async {
    String url = "https://blockchain.info/ticker";
    http.Response response = await http.get(url);
    Map<String, dynamic> cotation = json.decode(response.body);
    setState(() {
      _preco = cotation["BRL"]["buy"].toString();
      _preco_2 = cotation["USD"]["buy"].toString();
      print("BRL $_preco USD $_preco_2");
    });
    return cotation;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map>(
      future: requestUrl(),
      builder: (context, snapshot) => Scaffold(
        body: Container(
          padding: const EdgeInsets.all(32),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset("images/bitcoin.png"),
                Padding(
                  padding: const EdgeInsets.only(top: 30, bottom: 30),
                  child: Text(
                    "R\$ " + _preco + " papelzinho corolido",
                    style: const TextStyle(fontSize: 35),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30, bottom: 30),
                  child: Text(
                    "\$ " + _preco_2 + " Dorales",
                    style: const TextStyle(fontSize: 35),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 15, 30, 15),
                  child: ElevatedButton(
                    child: const Text(
                      "Atualizar",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    onPressed: () {
                      requestUrl();
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
