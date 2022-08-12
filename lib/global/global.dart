import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
SharedPreferences? sharedPreferences;

   var boxDecoration = BoxDecoration(
                gradient: LinearGradient(
                  colors:
                  [
                    Colors.green[900]!, Colors.pink[900]!, Colors.lightBlue[900]!,
                  ],
                  begin: FractionalOffset(0.0, 0.0),
                  end: FractionalOffset(1.0, 0.0),
                  stops: [0.0,0.5, 1.0],
                  tileMode: TileMode.clamp,
                )
            );