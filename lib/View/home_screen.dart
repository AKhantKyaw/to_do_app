import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes_app/Controller/notes_add_controller.dart';
import 'package:notes_app/Model/model.dart';
import 'package:notes_app/View/note_detail.dart';
import 'package:notes_app/View/notes_addscreen.dart';
class NotesApp extends StatefulWidget {
  const NotesApp({Key? key}) : super(key: key);

  @override
  State<NotesApp> createState() => _NotesAppState();
}

class _NotesAppState extends State<NotesApp> {
  NotesAddController controller = NotesAddController();
  bool isGrid = true;
  int crossAxisCount = 2;
  bool isDone = true;
  Color priorityStatusCheck(String priority) {
    if (priority == "high") {
      return Colors.red;
    }
    if (priority == "medium") {
      return Colors.black;
    }
    if (priority == "low") {
      return Colors.amber;
    }
    return Colors.black;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff8D8DAA),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xff8D8DAA),
        title: const Text(
          "Notes",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  if (isGrid) {
                    crossAxisCount = 1;
                    isGrid = false;
                  } else {
                    crossAxisCount = 2;
                    isGrid = true;
                  }
                });
              },
              icon: Icon(
                  isGrid ? Icons.format_align_justify_outlined : Icons.apps))
        ],
      ),
      body: FutureBuilder<List<Notes>>(
        future: controller.getNote(),
        builder: (context, AsyncSnapshot<List<Notes>> asyncSnapshot) {
          return controller.listnotes.isEmpty
              ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Add to Notes on tap Button",style: TextStyle(fontSize: 25),),
                  Image.network(
                      "https://www.pngkit.com/png/full/9-94669_yellow-sticky-notes-png-image-transparent-background-sticky.png"),
                ],
              )
              : SingleChildScrollView(
                  child: StaggeredGrid.count(
                    crossAxisCount: crossAxisCount,
                    children: [
                      for (Notes notes in controller.listnotes)
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return DetailNotes(id: notes.id!.toInt());
                                },
                              )).then((value) {
                                setState(() {});
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Color(notes.color),
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: Colors.white, width: 2)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: isGrid ?110:320,
                                          child: Text(
                                            notes.title,
                                            style: GoogleFonts.acme(
                                              fontSize: 20,
                                              decoration: notes.status == 0
                                                  ? TextDecoration.none
                                                  : TextDecoration.lineThrough,
                                            ),
                                          ),
                                        ),
                                        Icon(
                                          Icons.star_rounded,
                                          color: priorityStatusCheck(
                                              notes.prority),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    child: Text(
                                      notes.body,
                                      style: GoogleFonts.robotoMono(
                                              fontSize: 15,
                                              decoration: notes.status == 0
                                                  ? TextDecoration.none
                                                  : TextDecoration.lineThrough,
                                            ),
                                    ),
                                  ),
                                  Align(
                                      alignment: Alignment.bottomRight,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15, vertical: 10),
                                        child:
                                            Text(notes.date.substring(0, 10)),
                                      ))
                                ],
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: ((context) => NotesAddScreen(
                        isEdit: true,
                      )))).then((value) {
            setState(() {});
          });
        },
        child: const Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
    );
  }
}
