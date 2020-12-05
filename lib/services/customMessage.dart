import 'package:cloud_firestore/cloud_firestore.dart';

// Design messages for the chats

class CustomMessageServices {
  sendEventAcceptEventChatCustomMessage(
      String docId, String team, String eventName) async {
    await FirebaseFirestore.instance
        .collection('events')
        .doc(docId)
        .collection('chats')
        .doc()
        .set({
      'message': team + " just Joined !",
      'type': 'custom',
      'dateTime': DateTime.now(),
    });
  }

  sendEventAcceptTeamChatCustomMessage(
      String docId, String name, String eventName) async {
    await FirebaseFirestore.instance
        .collection('teams')
        .doc(docId)
        .collection('chats')
        .doc()
        .set({
      'message': "You Guys registered for " + eventName,
      'type': 'custom',
      'dateTime': DateTime.now(),
    });
  }

  sendTeamNewMemberJoinMessage(String docId, String name) async {
    await FirebaseFirestore.instance
        .collection('teams')
        .doc(docId)
        .collection('chats')
        .doc()
        .set({
      'message': name + " Joined You Guys",
      'type': 'custom',
      'dateTime': DateTime.now(),
    });
  }

  sendTeamLeaveMemberMessage(String docId, String name) async {
    await FirebaseFirestore.instance
        .collection('teams')
        .doc(docId)
        .collection('chats')
        .doc()
        .set({
      'message': "Kicked" + name,
      'type': 'custom',
      'dateTime': DateTime.now(),
    });
  }
}
