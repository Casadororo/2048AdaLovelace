import 'dart:ui';

import 'package:adalovelace/adalovelace/services/auth.dart';
import 'package:adalovelace/models.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:adalovelace/adalovelace/services/db.dart';

class Chat extends StatefulWidget{
  final String chatId;
  const Chat({Key key,this.chatId}) : super(key: key);

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> with WidgetsBindingObserver{
  double _overlap = 0;
  String textField = '';
  TextEditingController controller = new TextEditingController();
  List<Mensages> _mensages;

@override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    final renderObject = context.findRenderObject();
    final renderBox = renderObject as RenderBox;
    final offset = renderBox.localToGlobal(Offset.zero);
    final widgetRect = Rect.fromLTWH(
      offset.dx,
      offset.dy,
      renderBox.size.width,
      renderBox.size.height,
    );
    final keyboardTopPixels =
        window.physicalSize.height - window.viewInsets.bottom;
    final keyboardTopPoints = keyboardTopPixels / window.devicePixelRatio;
    final overlap = widgetRect.bottom - keyboardTopPoints;
    if (overlap >= 0) {
      setState(() {
        _overlap = overlap;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    double c_width = MediaQuery.of(context).size.width * 0.7;
    _mensages = Provider.of<List<Mensages>>(context) ?? new List<Mensages>(0);
    String uid = AuthService().userUser.uid;
    return Column(
      children: [
        Container(
          height: (MediaQuery.of(context).size.height * 0.785) - _overlap,
          child: ListView.builder(
            reverse: true,
            itemCount: _mensages.length,
            itemBuilder: (BuildContext context, int index) {
              return _mensages[index].uid != uid
                  ? Row(
                      children: [
                        Container(
                          constraints: BoxConstraints(maxWidth: c_width),
                          margin: EdgeInsets.only(left: 12, bottom: 12),
                          padding: EdgeInsets.all(6),
                          child: Text(_mensages[index].mensage),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 0.5),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        )
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          constraints: BoxConstraints(maxWidth: c_width),
                          margin: EdgeInsets.only(right: 12, bottom: 12),
                          padding: EdgeInsets.all(6),
                          child: Text(_mensages[index].mensage),
                          decoration: BoxDecoration(
                            color: Colors.pink[50],
                            border: Border.all(color: Colors.black, width: 0.5),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        )
                      ],
                    );
            },
          ),
        ),
        Divider(
          color: Colors.grey[500],
          thickness: 2,
        ),
        Container(
          margin: EdgeInsets.only(left: 12, right: 12),
          child: Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextField(
                  controller: controller,
                  onChanged: (val) {
                    setState(() {
                      textField = val;
                    });
                  },
                ),
              ),
              Center(
                child: IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () async {
                    String buffer = textField;
                    controller.text = '';
                    textField = '';
                    print("aio " + new DateTime.now().toString());
                    if (buffer != '') {
                      DbService dbService = new DbService();
                      await dbService.sendMensage(widget.chatId,
                          Mensagem(mensagem: buffer, uid: uid,time: new DateTime.now().toString()));
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
