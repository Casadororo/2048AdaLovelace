import 'package:adalovelace/adalovelace/screens/mainAda.dart';
import 'package:adalovelace/adalovelace/screens/whapper.dart';
import 'package:flutter/material.dart';

class GameOptions {
  bool _boolMusic = true;
  bool _boolSound = true;

  StatefulBuilder optionsDialog() {
    return StatefulBuilder(
      builder: (context, setState) {
        return SimpleDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor: Color.fromRGBO(255, 255, 255, 0.90),
          children: [
            Container(
              margin: EdgeInsets.only(top: 35, bottom: 5),
              alignment: Alignment.center,
              child: Text("Configurações"),
            ),
            Divider(
              color: Colors.grey[500],
              thickness: 1,
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Som"),
                    SizedBox(width: 100),
                    Switch(
                      value: _boolSound,
                      onChanged: (value) {
                        setState(() {
                          _boolSound = value;
                        });
                      },
                      activeTrackColor: Colors.lightGreenAccent,
                      activeColor: Colors.green,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Musica"),
                    SizedBox(width: 100),
                    Switch(
                      value: _boolMusic,
                      onChanged: (value) {
                        setState(() {
                          _boolMusic = value;
                        });
                      },
                      activeTrackColor: Colors.lightGreenAccent,
                      activeColor: Colors.green,
                    ),
                  ],
                ),
                SizedBox(
                  height: 13,
                ),
                InkWell(
                  splashColor: Color.fromRGBO(255, 255, 255, 0),
                  hoverColor: Color.fromRGBO(255, 255, 255, 0),
                  highlightColor: Color.fromRGBO(255, 255, 255, 0),
                  focusColor: Color.fromRGBO(255, 255, 255, 0),
                  onDoubleTap: () {
                    //Navigator.pop(context);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MainAda()));
                  },
                  child: Container(
                  margin: EdgeInsets.only(top: 12,bottom: 12),
                  alignment: Alignment.center,
                  child: Text("Equipe Ada Lovelace"),
                  )
                ),
                Divider(
                  color: Colors.grey[500],
                  thickness: 1,
                ),
                Container(
                  margin: EdgeInsets.only(top: 16),
                  alignment: Alignment.center,
                  child: Text("usecodelee"),
                ),
                Container(
                  margin: EdgeInsets.only(top: 12),
                  alignment: Alignment.center,
                  child: Text("Gabriel de Oliveira Pontarolo"),
                ),
                Container(
                  margin: EdgeInsets.only(top: 12),
                  alignment: Alignment.center,
                  child: Text("Luiz Fernando Giongo dos Santos"),
                ),
                Container(
                  margin: EdgeInsets.only(top: 12),
                  alignment: Alignment.center,
                  child: Text("Natã Abraão Serafini da Rocha"),
                ),
                Container(
                  margin: EdgeInsets.only(top: 12),
                  alignment: Alignment.center,
                  child: Text("Rodrigo Saviam Soffner"),
                ),
                Container(
                  margin: EdgeInsets.only(top: 12),
                  alignment: Alignment.center,
                  child: Text("Rubens Zandomenighi Laszlo"),
                ),
                Container(
                  margin: EdgeInsets.only(top:12, bottom: 44),
                  alignment: Alignment.center,
                  child: Text("Victor Ribeiro Garcia"),
                ),
              ],
            )
          ],
        );
      },
    );
  }
}
