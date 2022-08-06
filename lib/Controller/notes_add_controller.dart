import 'package:flutter/material.dart';
import 'package:notes_app/Model/model.dart';
import 'package:notes_app/Services/databasehelper.dart';

class NotesAddController{
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();
  DatabaseHelper databaseHelper = DatabaseHelper();
  Color color = const Color(0xffBB6464);
  String priority = "medium";
  List<Notes> listnotes = [];
  List<Notes> findnotes = [];
  PriorityStatus priorityStatus = PriorityStatus.medium;
  List<Color> colorPick = const [
    Color(0xffBB6464),
    Color(0xff7882A4),
    Color(0xff54BAB9),
    Color(0xffFF9F45),
    Color(0xffC3DBD9),
    Color(0xffB8405E),
    Color(0xffD3ECA7),
    Color(0xffFFADF0),
    Color(0xffC1DEAE),
    Color(0xff7897AB),
    Color(0xff1A1A40),
    Color(0xffFC28FB),
    Color(0xffC1A3A3),
    Color(0xffFFE162),
    Color(0xffE60965),
    Color(0xffCDDEFF),
    Color(0xff35589A),
    Color(0xff06FF00),
    Color(0xff781D42),
    Color(0xff84DFFF),
    Color(0xff98BAE7),
    Color(0xffFFC4E1),
    Color(0xff66806A),
    Color(0xffB91646),
    Color(0xffE5890A)
  ];
    addNote() {
    databaseHelper.insertNote(Notes(
        title: titleController.text,
        body: bodyController.text,
        date: DateTime.now().toString(),
        color: color.value,
        prority: priority,
        status: 0));
  }
   Future <List<Notes>>getNote()async{
   listnotes = await  databaseHelper.retrieveNotes();
   return listnotes;
}
deleteNote(int id)async{
 await databaseHelper.deleteNote(id);
}
updatenote(Notes notes)async{
  await databaseHelper.updatedata(notes);
}
  Future<List<Notes>>findbyId(int id)async{
  findnotes = await databaseHelper.findById(id);
 return findnotes;
}

}