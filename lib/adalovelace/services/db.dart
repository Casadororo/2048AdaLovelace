import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:adalovelace/models.dart';

class DbService {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<Chats>> streamChats(User user) {
    var ref = _db.collection("chat").where("users", arrayContains: user.uid);

    return ref.snapshots().map((event) =>
        event.docs.map((e) => Chats.fromFirestore(e, user.uid)).toList());
  }

  Stream<List<Mensages>> streamMensagens(User user, String chatId) {
    if (chatId != '') {
      var ref = _db.collection("chat").doc(chatId).collection("mensages").orderBy("time",descending: true);

      return ref.snapshots().map(
          (event) => event.docs.map((e) => Mensages.fromFirestore(e)).toList());
    } else
      return null;
  }

  Future<bool> addChat(String uid2, String name, String uid) async{
    await _db.collection("chat").add({"users":FieldValue.arrayUnion([uid,uid2]),uid:name}).then((a) {
      return true;
    });
    return true;
  }

  Future<bool> sendMensage(String chatId, Mensagem mensagem) async {
    await _db
        .collection("chat")
        .doc(chatId)
        .collection("mensages")
        .add(mensagem.toMap())
        .then((v) {
      return true;
    }, onError: (e) {
      return false;
    });
    return false;
  }
}
