import 'dart:async';
import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:segundoparcial/Models/Client.dart';
import 'package:segundoparcial/Screens/LoginPage.dart';
import 'package:segundoparcial/Utils/log_in_google.dart';
import 'clientDetailPage.dart';
import 'formClientPage.dart';
import 'package:light/light.dart';

final clientReference = FirebaseDatabase.instance.reference().child('client');

class MainPage extends StatefulWidget {
  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  Brightness brightness;
  int _luxString = 0;
  Light _light;
  StreamSubscription _subscription;
  StreamSubscription<Event> _onAddClient, _onUpdateClient;
  int count = 0;
  List<Client> clientList;

  void initState() {
    super.initState();
    clientList = new List();
    _onAddClient = clientReference.onChildAdded.listen(_addClient);
    _onUpdateClient = clientReference.onChildChanged.listen(_updateClient);
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

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _onAddClient.cancel();
    _onUpdateClient.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: getTheme(),
      home: new Scaffold(
          appBar: AppBar(
              centerTitle: true,
              title: const Text('Clientes'),
              actions: <Widget>[
                new IconButton(
                  icon: new Icon(Icons.exit_to_app),
                  onPressed: () {
                    signOutGoogle();
                    Navigator.of(context).pushAndRemoveUntil(
                        CupertinoPageRoute(builder: (context) {
                      return LoginPage();
                    }), ModalRoute.withName('/'));
                  },
                ),
              ]),
          body: ClientList(),
          floatingActionButton: Container(
            width: 70,
            height: 70,
            child: FittedBox(
              child: FloatingActionButton(
                backgroundColor: getTheme().accentColor,
                child: Icon(Icons.add),
                onPressed: () {
                  addNewClient(context);
                },
              ),
            ),
          )),
    );
  }

  Widget ClientList() {
    return Center(
      child: ListView.builder(
        itemCount: clientList.length,
        padding: EdgeInsets.only(top: 12),
        itemBuilder: (context, position) {
          return Column(children: <Widget>[
            Divider(
              height: 7,
            ),
            productCard(clientList[position], position)
          ]);
        },
      ),
    );
  }

  Widget productCard(Client client, position) {
    return Container(
      padding: new EdgeInsets.only(left: 15, top: 4, bottom: 3),
      margin: new EdgeInsets.only(left: 16, right: 17, top: 10),
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
                    client.first_name.toString() +
                        " " +
                        client.last_name.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                  Text(
                    client.age.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                  Text(
                    client.email,
                    textAlign: TextAlign.center,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new IconButton(
                          icon: new Icon(Icons.remove_red_eye),
                          tooltip: 'Ver producto',
                          onPressed: () =>
                              _navigateToClientDetail(context, client)),
                      new IconButton(
                          icon: new Icon(Icons.edit),
                          tooltip: 'Editar producto',
                          onPressed: () =>
                              _navigateToFormClient(context, client)),
                      new IconButton(
                        icon: new Icon(Icons.delete),
                        tooltip: 'Eliminar producto',
                        onPressed: () =>
                            _showAlertDialog(context, client, position),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showAlertDialog(BuildContext context, Client client, position) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(
        '¿Segruo que desea eliminar a ' + client.first_name + '?',
      ),
      content: Container(
        width: 400,
        height: 150,
        child: Column(
          children: <Widget>[
            /*Image.file(
              File(product.photo),
              width: 70,
              height: 70,
            ),*/
            Row(
              children: <Widget>[
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      margin: new EdgeInsets.only(left: 5, right: 5, top: 10),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: new Border.all(color: getTheme().accentColor),
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      ),
                      child: Text(
                        "Volver",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      padding: EdgeInsets.only(top: 9, bottom: 9),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      _deleteClient(context, client, position);
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      margin: new EdgeInsets.only(left: 5, right: 5, top: 10),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: new Border.all(color: getTheme().accentColor),
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      ),
                      child: Text(
                        "Confirmar",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      padding: EdgeInsets.only(top: 9, bottom: 9),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
    showDialog(context: context, builder: (_) => alertDialog);
  }

  void _addClient(Event event) {
    setState(() {
      clientList.add(new Client.fromSnapShot(event.snapshot));
    });
  }

  void _updateClient(Event event) {
    var oldClientValue =
        clientList.singleWhere((client) => client.client == event.snapshot.key);
    setState(() {
      clientList[clientList.indexOf(oldClientValue)] =
          new Client.fromSnapShot(event.snapshot);
    });
  }

  void _deleteClient(BuildContext context, Client client, int position) async {
    await clientReference.child(client.client.toString()).remove().then((_) {
      setState(() {
        clientList.removeAt(position);
      });
    });
  }

  void _navigateToClientDetail(BuildContext context, Client client) async {
    //stopListening();
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ClientDetailPage(client)),
    );
  }

  void _navigateToFormClient(BuildContext context, Client client) async {
    //stopListening();
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FormClientPage(client)),
    );
  }

  void addNewClient(BuildContext context) async {
    //stopListening();
    await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              FormClientPage(Client.withId(null, null, null, null, null))),
    );
  }
}
