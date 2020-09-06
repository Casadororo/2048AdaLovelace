import 'package:cloud_firestore/cloud_firestore.dart';

class Chats {
  final String id;
  final String name;
  final List<String> users;

  Chats({this.id, this.name, this.users});

  @override
  String toString() {
    return "Id:" + id.toString();
  }

  factory Chats.fromFirestore(DocumentSnapshot doc, String uid) {
    Map data = doc.data();

    return Chats(
      id: doc.id ?? '',
      name: data[uid] ?? null,
      users: new List<String>.from(data['users'] ?? new List<String>(0)),
    );
  }
}

class Mensages {
  final String id;
  final String uid;
  final String mensage;

  Mensages({this.id, this.uid, this.mensage});

  @override
  String toString() {
    return '';
  }

  factory Mensages.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data();

    return Mensages(
        id: doc.id ?? '',
        uid: data['uid'] ?? '',
        mensage: data['mensage'] ?? '');
  }
}

class Mensagem {
  final String mensagem;
  final String uid;
  final String time;

  Mensagem({this.mensagem, this.uid, this.time});

  toMap() {
    return {"mensage": mensagem, "uid": uid, "time":time};
  }
}
