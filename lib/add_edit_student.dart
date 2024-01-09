import 'package:flutter/material.dart';
import 'inputextfield.dart';
import 'model.dart';
import 'student_controller.dart';
import 'students.dart';

class Add_Edit_Student extends StatefulWidget {
  final studentModel? studentmodel;
  final index;


  const Add_Edit_Student({this.studentmodel, this.index});

  @override
  State<Add_Edit_Student> createState() => _Add_Edit_StudentState();
}

class _Add_Edit_StudentState extends State<Add_Edit_Student> {
  bool isEdited_mode = false;

  final _form_key = GlobalKey<FormState>();
  TextEditingController Name = TextEditingController();
  TextEditingController Email = TextEditingController();
  TextEditingController Address = TextEditingController();
  TextEditingController id = TextEditingController();

  AddStudent(studentModel studentModel) async {
    await StudentController()
        .addStudent(studentModel)
        .then((success) => {Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) => StudentsPage())))});
  }

  UpdateStudent(studentModel studentmodel) async {
    await StudentController().UpdateStudent(studentmodel)
        .then((success) => {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: ((context) => StudentsPage())))});

  }

  @override
  void initState() {
    // TODO: implement initState
    if(widget.index != null){
      isEdited_mode = true;
      Name.text = widget.studentmodel?.Name;
      Email.text = widget.studentmodel?.Email;
      Address.text = widget.studentmodel?.Address;
      id.text = widget.studentmodel?.id;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text( isEdited_mode ? "Edit Student" : "Add Student"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 30.0,),
            Center(
              child: Text("Student Registration",
                style: TextStyle(fontSize: 30.0),),
            ),
            SizedBox(height: 30.0,),
            Form(
                key: _form_key,
                child: Column(
                  children: [
                    MyTextFields(
                      hintedtext: "Full Name",
                      labeltext: "Name",
                      inputcontroller: Name ,
                    ),
                    SizedBox(height: 10.0,),
                    MyTextFields(
                      hintedtext: "Example@gmail.com",
                      labeltext: "Email",
                      inputcontroller: Email,
                    ),
                    SizedBox(height: 10.0,),
                    MyTextFields(
                      hintedtext: "Beirut, Akkar, Byblos",
                      labeltext: "Address",
                      inputcontroller: Address,
                    ),
                  ],
                ) ),
            SizedBox(height: 10.0),

            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(300.0, 60),
                  elevation: 20.0,
                ),
                onPressed: (){
                  if(isEdited_mode == true){
                    if (_form_key.currentState!.validate()) {
                      studentModel studenModel = studentModel(
                          id: id.text,
                          Name: Name.text,
                          Email: Email.text,
                          Address: Address.text);
                      UpdateStudent(studenModel);
                      Name.clear();
                      Email.clear();
                      Address.clear();
                    }
                  }else{
                    if (_form_key.currentState!.validate()) {
                      studentModel studenModel = studentModel(
                          Name: Name.text,
                          Email: Email.text,
                          Address: Address.text);
                      AddStudent(studenModel);
                      Name.clear();
                      Email.clear();
                      Address.clear();
                    }
                  }
                }, child: Text(isEdited_mode ? "Update" : "Save"))
          ],
        ),
      ),
    );
  }
}