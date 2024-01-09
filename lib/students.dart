import 'dart:async';
import 'add_edit_student.dart';
import 'student_controller.dart';
import 'package:flutter/material.dart';
import 'model.dart';

class StudentsPage extends StatefulWidget {
  const StudentsPage({super.key});

  @override
  State<StudentsPage> createState() => _StudentsPageState();
}

class _StudentsPageState extends State<StudentsPage> {

  List<studentModel> studentlist = [];

  StreamController _streamController = StreamController();

  Future getAllStudents() async {
    studentlist = await StudentController().getStudents();
    _streamController.sink.add(studentlist);
  }

  deleteStudent(studentModel studentModel) async {
    await StudentController()
        .DeleteStudent(studentModel)
        .then((success) => null)
        .onError((error, stackTrace) => null);
  }

  @override
  void initState() {
    Timer.periodic(Duration(seconds: 1),(timer){
      getAllStudents();
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => Add_Edit_Student()));
      },
          child: Icon(Icons.add)),
      appBar: AppBar(
        title: Text("Students"),
      ),
      body: SafeArea(
          child: StreamBuilder(
              stream: _streamController.stream,
              builder: (context, snapshots){
                if(snapshots.hasData){
                  return  ListView.builder(
                      itemCount: studentlist.length,
                      itemBuilder: ((context, index) {
                        studentModel student = studentlist[index];
                        return ListTile(
                          onTap: (){
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context)=> Add_Edit_Student(
                              studentmodel: student, index: index,
                            ))));
                          },
                          leading: CircleAvatar(child: Text(student.Name[0]),),
                          title: Text(student.Name),
                          subtitle: Text(student.Email),
                          trailing: IconButton(
                            onPressed: (){
                              deleteStudent(student);
                            },
                            icon: Icon(Icons.delete_outline, color: Colors.red,),),
                        );
                      }));
                }
                return Center(child: CircularProgressIndicator(),
                );
              }
          )
      ),
    );
  }
}