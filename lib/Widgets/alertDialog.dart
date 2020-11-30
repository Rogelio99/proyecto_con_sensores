import 'package:segundoparcial/Models/Client.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void _showAlertDialog(BuildContext context, Client client) {
  AlertDialog alertDialog = AlertDialog(
    title: Text('¿Segruo que desea eliminar a ' + client.first_name + '?'),
    content: Container(
      width: 400,
      height: 150,
      child: Row(
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
                Navigator.of(context).pop();
              },
              child: Container(
                margin: new EdgeInsets.only(left: 5, right: 5, top: 10),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                ),
                child: Text(
                  "Confirmar",
                  style: TextStyle(
                    color: Colors.white,
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
    ),
  );
  showDialog(context: context, builder: (_) => alertDialog);
}
