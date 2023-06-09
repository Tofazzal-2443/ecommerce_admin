import 'package:flutter/material.dart';
import '../db/bd_helper.dart';
import '../models/user_model.dart';

class UserProvider extends ChangeNotifier {
  List<UserModel> userList = [];

  Future<bool> doesUserExist(String uid) => DbHelper.doesUserExist(uid);

  getAllUser() {
    DbHelper.getAllUsers().listen((snapshot) {
      userList = List.generate(snapshot.docs.length,
              (index) => UserModel.fromMap(snapshot.docs[index].data()));
      notifyListeners();
    });
  }
}
