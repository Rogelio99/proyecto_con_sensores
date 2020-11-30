import 'package:firebase_database/firebase_database.dart';

class Client {
  String _client;
  String _first_name;
  String _last_name;
  String _email;
  String _age;

  Client(this._first_name, this._last_name, this._age, this._email);

  Client.withId(
      this._client, this._first_name, this._last_name, this._age, this._email);

  Client.fromSnapShot(DataSnapshot snapshot) {
    _client = snapshot.key;
    _first_name = snapshot.value['first_name'];
    _last_name = snapshot.value['last_name'];
    _age = snapshot.value['age'];
    _email = snapshot.value['email'];
  }

  String get age => _age;
  set age(String value) {
    _age = value;
  }

  String get email => _email;
  set email(String value) {
    _email = value;
  }

  String get last_name => _last_name;
  set last_name(String value) {
    _last_name = value;
  }

  String get first_name => _first_name;
  set first_name(String value) {
    _first_name = value;
  }

  String get client => _client;
  set client(String value) {
    _client = value;
  }
}
