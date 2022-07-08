import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';

class DataListProvider extends ChangeNotifier{

  final ref = FirebaseDatabase.instance.ref().child('Posts');
  var searchController = TextEditingController();
  String search = '';

  void searchMethod(){
    search = searchController.text;
    notifyListeners();
  }

}