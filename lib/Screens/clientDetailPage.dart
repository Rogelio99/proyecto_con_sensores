import 'dart:async';
import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:segundoparcial/Models/Client.dart';
import 'package:light/light.dart';

final clientReference = FirebaseDatabase.instance.reference().child('client');

class ClientDetailPage extends StatefulWidget {
  final Client client;

  ClientDetailPage(this.client);

  @override
  ClientDetailPageState createState() => ClientDetailPageState();
}

class ClientDetailPageState extends State<ClientDetailPage> {
  List<Client> clientList;
  Brightness brightness;
  int _luxString = 0;
  Light _light;
  StreamSubscription _subscription;

  @override
  void initState() {
    super.initState();
    if (!mounted) return;
    //initPlatformState();
  }

  /*Future<void> initPlatformState() async {
    startListening();
  }*/

  ThemeData getTheme() {
    //if (_luxString <= 50) {
    return ThemeData.dark();
    /*} else {
      return ThemeData.light();
    }*/
  }

  /*void onData(int luxValue) async {
    //print("Lux value: $luxValue");

    setState(() {
      _luxString = luxValue;
    });
  }

  void stopListening() {
    _subscription.cancel();
  }

  void startListening() {
    _light = new Light();
    try {
      _subscription = _light.lightSensorStream.listen(onData);
    } on LightException catch (exception) {
      print(exception);
    }
  }*/

  GlobalKey<FormState> keyForm = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: getTheme(),
      home: new Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Client Detail'),
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                moveToLastScreen(); // Write some code to control things, when user press back button in AppBar
              }),
        ),
        body: Container(
          child: SingleChildScrollView(child: clientCard(widget.client)),
        ),
      ),
    );
  }

  formItemsDesign(item) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2),
      child: Container(
        margin: new EdgeInsets.only(top: 1),
        child: ListTile(title: item),
        padding: EdgeInsets.only(top: 0, bottom: 0),
      ),
    );
  }

  decorationInput(text) {
    return InputDecoration(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(30.0)),
      ),
      labelText: text,
    );
  }

  Widget clientCard(Client client) {
    return Container(
      padding: new EdgeInsets.only(left: 15, top: 4, bottom: 3),
      margin: new EdgeInsets.only(left: 16, right: 17, top: 20),
      decoration: new BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        border: new Border.all(color: Colors.black38),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Expanded(
            child: Container(
              child: Column(
                children: <Widget>[
                  Text(
                    client.first_name + " " + client.last_name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 45,
                    ),
                  ),
                  Text(
                    client.age.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                  Text(
                    client.email,
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void moveToLastScreen() {
    //stopListening();
    Navigator.pop(context, true);
  }
}
