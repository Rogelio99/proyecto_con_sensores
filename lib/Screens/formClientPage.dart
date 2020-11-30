import 'dart:async';
import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:segundoparcial/Models/Client.dart';
import 'package:light/light.dart';

final clientReference = FirebaseDatabase.instance.reference().child('client');

class FormClientPage extends StatefulWidget {
  final Client client;

  FormClientPage(
    this.client,
  );

  @override
  _FormClientPageState createState() => _FormClientPageState();
}

class _FormClientPageState extends State<FormClientPage> {
  Brightness brightness;
  int _luxString = 0;
  Light _light;
  StreamSubscription _subscription;
  List<Client> clientList;
  GlobalKey<FormState> keyForm = new GlobalKey();
  TextEditingController firstNameCtrl, lastNameCtrl, ageCtrl, emailCtrl;
  String title = 'Nuevo cliente';

  @override
  void initState() {
    super.initState();
    firstNameCtrl = new TextEditingController(text: widget.client.first_name);
    lastNameCtrl = new TextEditingController(text: widget.client.last_name);
    ageCtrl = new TextEditingController(text: widget.client.age);
    emailCtrl = new TextEditingController(text: widget.client.email);
    if (!mounted) return;
    //startListening();
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
  Widget build(BuildContext context) {
    if (widget.client.first_name != null) {
      title = 'Editar cliente';
    } else {
      title = 'Insertar cliente';
    }
    return MaterialApp(
      theme: getTheme(),
      home: new Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Cliente'),
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                // Write some code to control things, when user press back button in AppBar
                moveToLastScreen();
              }),
        ),
        body: Container(
          child: SingleChildScrollView(
              child: Column(
            children: <Widget>[
              new Form(
                key: keyForm,
                child: formUI(),
              ),
            ],
          )),
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
      fillColor: getTheme().bottomAppBarColor,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(30.0)),
      ),
      labelText: text,
    );
  }

  Widget formUI() {
    return Column(
      children: <Widget>[
        Container(
          margin: new EdgeInsets.only(top: 20),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Container(
            child: new Icon(
          Icons.person_outline,
          size: 200,
        )),
        formItemsDesign(
          TextFormField(
            controller: firstNameCtrl,
            decoration: decorationInput('Nombre(s)'),
            keyboardType: TextInputType.text,
            validator: validateText,
          ),
        ),
        formItemsDesign(
          TextFormField(
            controller: lastNameCtrl,
            decoration: decorationInput('Apellidos'),
            keyboardType: TextInputType.text,
            validator: validateText,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: formItemsDesign(
                TextFormField(
                  controller: ageCtrl,
                  decoration: decorationInput('Edad'),
                  keyboardType: TextInputType.numberWithOptions(
                      decimal: true, signed: false),
                  validator: validateNumber,
                ),
              ),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: formItemsDesign(
                TextFormField(
                  controller: emailCtrl,
                  decoration: decorationInput('Email'),
                  keyboardType: TextInputType.emailAddress,
                  validator: validateEmail,
                ),
              ),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: GestureDetector(
                onTap: () {
                  moveToLastScreen();
                },
                child: Container(
                  margin: new EdgeInsets.only(left: 30, right: 30, top: 40),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: new Border.all(color: getTheme().accentColor),
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  ),
                  child: Text(
                    "Cancelar",
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
                  if (keyForm.currentState.validate()) {
                    if (widget.client.client != null) {
                      clientReference.child(widget.client.client).set({
                        'first_name': firstNameCtrl.text,
                        'last_name': lastNameCtrl.text,
                        'age': ageCtrl.text,
                        'email': emailCtrl.text,
                      }).then((_) {
                        Navigator.pop(context);
                      });
                    } else {
                      clientReference.push().set({
                        'first_name': firstNameCtrl.text,
                        'last_name': lastNameCtrl.text,
                        'age': ageCtrl.text,
                        'email': emailCtrl.text,
                      }).then((_) {
                        Navigator.pop(context);
                      });
                    }
                  }
                },
                child: Container(
                  margin: new EdgeInsets.only(left: 30, right: 30, top: 40),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: new Border.all(color: getTheme().accentColor),
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  ),
                  child: Text(
                    "Guardar",
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
        ),
      ],
    );
  }

  String validateText(String value) {
    String pattern = r'(^[A-Za-z- áéíóúü]{4,}$)';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return "Campo requerido";
    } else if (!regExp.hasMatch(value)) {
      return "Este campo debe de ser a-z y A-Z";
    }
    return null;
  }

  String validateNumber(String value) {
    String pattern = r'([0-9]+(\.[0-9][0-9]?)?)';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0)
      return "Campo requerido";
    else if (!regExp.hasMatch(value)) return "Valor invalido";

    return null;
  }

  String validateEmail(String value) {
    String pattern =
        r'^[_a-z0-9-]+(.[_a-z0-9-]+)*@[a-z0-9-]+(.[a-z0-9-]+)*(.[a-z]{2,4})$';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0)
      return "Campo requerido";
    else if (!regExp.hasMatch(value)) return "Email invalido";

    return null;
  }

  void moveToLastScreen() {
    //stopListening();
    Navigator.pop(context, true);
  }
}
