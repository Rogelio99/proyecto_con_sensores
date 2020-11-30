import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:adobe_xd/pinned.dart';
import 'package:segundoparcial/Utils/log_in_google.dart';
import 'package:segundoparcial/Screens/MainPage.dart';
import 'package:segundoparcial/Widgets/batmanAnimator.dart';

class LoginPage extends StatelessWidget {
  LoginPage({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: Stack(
        children: <Widget>[
          Transform.translate(
            offset: Offset(0, 0),
            child:
                // Adobe XD layer: 'IMG_20191226_184712' (shape)
                Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: const AssetImage('assets/background_login.jpg'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(1.0, 0.0),
            child: ClipRect(
              child: BackdropFilter(
                filter: ui.ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
                child: Container(
                  width: 412.0,
                  height: 847.0,
                  decoration: BoxDecoration(
                    color: const Color(0x542a2121),
                  ),
                ),
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(81.0, 388.0),
            child: GestureDetector(
              onTap: () {
                print("Estoy sirviendo");
                signInWithGoogle().whenComplete(() {
                  Navigator.of(context).push(BatmanPageRoute(MainPage()));
                });
              },
              child: SizedBox(
                width: 251.0,
                height: 71.0,
                child: Stack(
                  children: <Widget>[
                    Pinned.fromSize(
                      bounds: Rect.fromLTWH(0.0, 0.0, 251.0, 71.0),
                      size: Size(251.0, 71.0),
                      pinLeft: true,
                      pinRight: true,
                      pinTop: true,
                      pinBottom: true,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(36.0),
                          color: const Color(0xffffffff),
                        ),
                      ),
                    ),
                    Pinned.fromSize(
                      bounds: Rect.fromLTWH(34.0, 12.0, 104.0, 48.0),
                      size: Size(251.0, 71.0),
                      pinLeft: true,
                      fixedWidth: true,
                      fixedHeight: true,
                      child: Text(
                        'Inicia sesion con google',
                        style: TextStyle(
                          fontFamily: 'Microsoft YaHei',
                          fontSize: 18,
                          color: const Color(0xff707070),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Pinned.fromSize(
                      bounds: Rect.fromLTWH(168.0, 12.0, 47.0, 47.0),
                      size: Size(251.0, 71.0),
                      pinRight: true,
                      pinTop: true,
                      pinBottom: true,
                      fixedWidth: true,
                      child:
                          // Adobe XD layer: 'google_logo' (shape)
                          Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: const AssetImage('assets/google_logo.png'),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
