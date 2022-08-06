import 'package:flutter/material.dart';
import 'package:notes_app/Controller/notes_add_controller.dart';
import 'package:notes_app/Model/model.dart';
class NotesAddScreen extends StatefulWidget {
  bool isEdit;
  Notes? notes;
  NotesAddScreen({Key? key, required this.isEdit, this.notes})
      : super(key: key);

  @override
  State<NotesAddScreen> createState() => _NotesAddScreenState();
}

class _NotesAddScreenState extends State<NotesAddScreen> {
  NotesAddController controller = NotesAddController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    if (widget.notes != null) {
      controller.titleController.text = widget.notes!.title;
      controller.bodyController.text = widget.notes!.body;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        backgroundColor: const Color(0xff8D8DAA),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color(0xff8D8DAA),
          title: const Text("Notes"),
        ),
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
            height: 60,
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          controller.priorityStatus = PriorityStatus.low;
                          controller.priority = "low";
                        });
                      },
                      child: Container(
                        child: const Center(child: Text("Low")),
                        decoration: BoxDecoration(
                            color:
                                controller.priorityStatus == PriorityStatus.low
                                    ? Colors.amber
                                    : Colors.transparent,
                            border:
                                Border.all(color: controller.color, width: 1)),
                        height: 40,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          controller.priorityStatus = PriorityStatus.medium;
                          controller.priority = "medium";
                        });
                      },
                      child: Container(
                        child: const Center(child: Text("Medium")),
                        decoration: BoxDecoration(
                            color: controller.priorityStatus ==
                                    PriorityStatus.medium
                                ? Colors.white
                                : Colors.transparent,
                            border:
                                Border.all(color: controller.color, width: 1)),
                        height: 40,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          controller.priorityStatus = PriorityStatus.high;
                          controller.priority = "high";
                        });
                      },
                      child: Container(
                        child: const Center(child: Text("High")),
                        decoration: BoxDecoration(
                            color:
                                controller.priorityStatus == PriorityStatus.high
                                    ? Colors.red
                                    : Colors.transparent,
                            border:
                                Border.all(color: controller.color, width: 1)),
                        height: 40,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 70,
            child: ListView.builder(
              itemCount: 16,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        controller.color = controller.colorPick[index];
                      });
                    },
                    child: CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.black,
                      child: CircleAvatar(
                        backgroundColor: controller.colorPick[index],
                        radius: 23,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "Title",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: controller.color),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextFormField(
              controller: controller.titleController,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: controller.color)),
                focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white)),
                border: const OutlineInputBorder(),
                hintText: 'Title',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "Body",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: controller.color),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextFormField(
              controller: controller.bodyController,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: controller.color)),
                focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white)),
                border: const OutlineInputBorder(),
                hintText: 'Body',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
          ),
        ]),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              if (widget.isEdit = true) {
                if (widget.notes != null) {
                  controller.updatenote(Notes(
                      id: widget.notes!.id,
                      title: controller.titleController.text,
                      body: controller.bodyController.text,
                      date: DateTime.now().toString(),
                      color: controller.color.value,
                      prority: controller.priority,
                      status: 0));
                      Navigator.pop(context);
                }
                 else {
                widget.isEdit = false;
                controller.addNote();
                controller.getNote();
                Navigator.pop(context);
              }
              }
            }
          },
          child: Icon(
            widget.isEdit ? Icons.add : Icons.edit,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
