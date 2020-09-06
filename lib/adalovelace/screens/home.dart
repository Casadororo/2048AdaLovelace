import 'package:adalovelace/adalovelace/screens/chat.dart';
import 'package:adalovelace/adalovelace/services/auth.dart';
import 'package:adalovelace/adalovelace/services/db.dart';
import 'package:adalovelace/models.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Chats> _chats;
  List<Mensages> _mensages;
  String chatId = '';
  String uid;
  String textField = '',textFieldNome = '';

  @override
  Widget build(BuildContext context) {
    _chats = Provider.of<List<Chats>>(context) ?? new List<Chats>(0);
    uid = AuthService().userUser.uid;

    return Scaffold(
      floatingActionButton: chatId == ''
          ? FloatingActionButton(
              onPressed: null,
              child: Icon(Icons.contactless),
              backgroundColor: Colors.pink[200],
            )
          : null,
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        centerTitle: true,
        title: chatId != ''
            ? InkWell(
                child: Text("Voltar"),
                onTap: () {
                  setState(() {
                    chatId = '';
                  });
                },
              )
            : InkWell(
                child: Text("Adicionar Conversa"),
                onTap: () {
                  showDialog(
                      barrierColor: Color.fromRGBO(255, 255, 255, 0.7),
                      context: context,
                      builder: (BuildContext context) {
                        return SimpleDialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          backgroundColor: Color.fromRGBO(255, 255, 255, 0.90),
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 35, bottom: 5),
                              alignment: Alignment.center,
                              child: Text("Seu Identificador"),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 7, bottom: 5),
                              alignment: Alignment.center,
                              child: Text(uid),
                            ),
                            Divider(
                              color: Colors.grey[500],
                              thickness: 1,
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 35, bottom: 5),
                              alignment: Alignment.center,
                              child: Text("Adicionar nova Conversa"),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  top: 7, bottom: 5, left: 10, right: 10),
                              alignment: Alignment.center,
                              child: TextField(
                                textAlign: TextAlign.center,
                                autocorrect: false,
                                enableSuggestions: false,
                                decoration: InputDecoration(
                                    //border: InputBorder.none,
                                    hintText: "Identificador",
                                    hintStyle: TextStyle(color: Colors.grey)),
                                onChanged: (va) {
                                  setState(() {
                                    textField = va;
                                  });
                                },
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  top: 7, bottom: 5, left: 10, right: 10),
                              alignment: Alignment.center,
                              child: TextField(
                                textAlign: TextAlign.center,
                                autocorrect: false,
                                enableSuggestions: false,
                                decoration: InputDecoration(
                                    //border: InputBorder.none,
                                    hintText: "Nome",
                                    hintStyle: TextStyle(color: Colors.grey)),
                                onChanged: (va) {
                                  setState(() {
                                    textFieldNome = va;
                                  });
                                },
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.done),
                                  onPressed: () async {
                                    if(textField != ''){
                                      if(await DbService().addChat(textField, textFieldNome, uid)){
                                        Navigator.pop(context);
                                      }
                                    }
                                  },
                                  alignment: Alignment.center,
                                ),
                                IconButton(
                                  icon: Icon(Icons.clear),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  alignment: Alignment.center,
                                ),
                              ],
                            )
                          ],
                        );
                      });
                },
              ),
        backgroundColor: Colors.pink[200],
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              AuthService().logout();
            },
          ),
        ],
      ),
      body: chatId == ''
          ? buildListChatContainer()
          : StreamProvider<List<Mensages>>.value(
              value:
                  DbService().streamMensagens(AuthService().userUser, chatId),
              child: Chat(
                chatId: chatId,
              ),
            ),
    );
  }

  Container buildListChatContainer() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: ListView.builder(
        itemCount: _chats.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              setState(() {
                chatId = _chats[index].id;
              });
            },
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 0.5),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    height: 70,
                    //color: Colors.black,
                    child: Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          width: (MediaQuery.of(context).size.width * 0.88) -
                              12 -
                              20,
                          //height: 1000000,
                          child: Text(_chats[index].name ?? 'Anônimo'),
                          //color: Colors.blue,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.12,
                          //color: Colors.orange,
                          child: LayoutBuilder(builder: (context, constraint) {
                            return Icon(
                              Icons.arrow_forward_ios,
                              size: constraint.biggest.width / 2,
                              color: Colors.black54,
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
