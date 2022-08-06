import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes_app/Controller/notes_add_controller.dart';
import 'package:notes_app/Model/model.dart';
import 'package:notes_app/View/Button/expended_FAB.dart';
import 'package:notes_app/View/home_screen.dart';
import 'package:notes_app/View/notes_addscreen.dart';

class DetailNotes extends StatefulWidget {
  int id;
  DetailNotes({Key? key, required this.id}) : super(key: key);

  @override
  State<DetailNotes> createState() => _DetailNotesState();
}

class _DetailNotesState extends State<DetailNotes> {
  NotesAddController controller = NotesAddController();
  bool isDone = true;
  showMyDialog(int id) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.indigo,
          title: const Text('Delete'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Are you sure delete this notes?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'No',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: const Text(
                'Yes',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                controller.deleteNote(id);
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NotesApp(),
                    ),
                    (route) => false);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xff8D8DAA),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color(0xff8D8DAA),
          title: const Text("Notes"),
        ),
        body: FutureBuilder<List<Notes>>(
            future: controller.findbyId(widget.id),
            builder: ((context, AsyncSnapshot<List<Notes>> asyncSnapshot) {
              return Column(
                children: [
                  for (Notes notes in controller.findnotes)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Title",
                            style: GoogleFonts.akronim(
                              fontSize: 40,
                              color: Colors.black,
                              letterSpacing: 1,
                            ),
                          ),
                          Text(notes.title,
                              style: GoogleFonts.magra(
                                  decoration: notes.status == 0
                                      ? TextDecoration.none
                                      : TextDecoration.lineThrough,
                                  fontSize: 25,
                                  color: Color(notes.color))),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Body",
                            style: GoogleFonts.akronim(
                                fontSize: 40,
                                color: Colors.black,
                                letterSpacing: 1),
                          ),
                          Text(notes.body,
                              style: GoogleFonts.magra(
                                  decoration: notes.status == 0
                                      ? TextDecoration.none
                                      : TextDecoration.lineThrough,
                                  fontSize: 25,
                                  color: Color(notes.color)))
                        ],
                      ),
                    )
                ],
              );
            })),
        floatingActionButton:
            Threefloatingactionbuttton(distance: 100, children: [
          ActionButton(
            color: Colors.white,
            icon: Icon(Icons.edit),
            onPressed: () {
              for (Notes notes in controller.findnotes) {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return NotesAddScreen(
                      isEdit: false,
                      notes: notes,
                    );
                  },
                )).then((value) {
                  setState(() {});
                });
              }
            },
          ),
          ActionButton(
            color: Colors.white,
            icon: const Icon(Icons.delete),
            onPressed: () {
              showMyDialog(widget.id);
            },
          ),
          ActionButton(
            color: Colors.white,
            icon: Icon(isDone ? Icons.check : Icons.close),
            onPressed: () {
              setState(() {
                if (isDone) {
                  isDone = false;
                  for (Notes note in controller.findnotes) {
                    controller.updatenote(Notes(
                        id: widget.id,
                        title: note.title,
                        body: note.body,
                        date: DateTime.now().toString(),
                        color: note.color,
                        prority: note.prority,
                        status: 1));
                  }
                } else {
                  isDone = true;
                  for (Notes note in controller.findnotes) {
                    controller.updatenote(Notes(
                        id: widget.id,
                        title: note.title,
                        body: note.body,
                        date: DateTime.now().toString(),
                        color: note.color,
                        prority: note.prority,
                        status: 0));
                  }
                }
              });
            },
          )
        ]));
  }
}
