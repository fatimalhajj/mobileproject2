import 'dart:convert';
import 'model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'model.dart';


class StudentController{

  static const CREATE_URL = "https://green-eyed-mothers.000webhostapp.com/create.php";
  static const DELETE_URL = "https://green-eyed-mothers.000webhostapp.com/delete.php";
  static const UPDATE_URL = "https://green-eyed-mothers.000webhostapp.com/update.php";

  List<studentModel> studentFromJson(String jsonstring) {
    final data = json.decode(jsonstring);
    return List<studentModel>.from(
        data.map((item)=> studentModel.fromJson(item)));
  }

  Future<List<studentModel>> getStudents() async {
    String view_ip = "https://green-eyed-mothers.000webhostapp.com/view.php";
    final response = await http.get(Uri.parse(view_ip));
    if(response.statusCode == 200){
      List<studentModel> list = studentFromJson(response.body);
      return list;
    } else{
      return <studentModel>[];
    }
  }

  Future<String> addStudent(studentModel studentModel) async {
    final response = await http.post(Uri.parse(CREATE_URL), body: studentModel.toJsonAdd());
    if(response.statusCode == 200) {
      return response.body;
    }else {
      return "Error";
    }
  }

  Future<String> UpdateStudent(studentModel studentModel) async{
    final response = await http.post(Uri.parse(UPDATE_URL), body: studentModel.toJsonDelete_and_Update());
    if(response.statusCode == 200) {
      return response.body;
    }else {
      return "Error";
    }
  }

  Future<String> DeleteStudent(studentModel studentModel) async{
    final response = await http.post(Uri.parse(DELETE_URL), body: studentModel.toJsonDelete_and_Update());
    if(response.statusCode == 200) {
      return response.body;
    }else {
      return "Error";
    }
  }

}