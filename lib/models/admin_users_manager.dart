import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:loja_principal/models/user.dart';
import 'package:loja_principal/models/user_manager.dart';

class AdminUsersManager extends ChangeNotifier {
  List<User> users = [];

  final Firestore firestore = Firestore.instance;

  StreamSubscription _subscription;
  void updateUser(UserManager userManager) {
    _subscription?.cancel();
    if (userManager.adminEnabled) {
      _listToUsers();
    } else {
      users.clear();
      notifyListeners();
    }
  }

  void _listToUsers() {
    /* Mostrar via getDocument  
    firestore.collection('users').getDocuments().then((snapshot) {
      users = snapshot.documents.map((e) => User.fromDocument(e)).toList();
      users
          .sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
      notifyListeners();
    });*/

    /* Mostrar via Snapshot */
    _subscription =
        firestore.collection('users').snapshots().listen((snapshot) {
      users = snapshot.documents.map((e) => User.fromDocument(e)).toList();
      users
          .sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
      notifyListeners();
    });
  }

  List<String> get names => users.map((e) => e.name).toList();
  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
