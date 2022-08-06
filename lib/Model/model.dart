enum PriorityStatus { low, medium, high }

class Notes {
  int ? id;
  String title;
  String body;
  String date;
  int color;
  String prority;
  int status;
  Notes(
      {  this.id,
      required this.title,
      required this.body,
      required this.date,
      required this.color,
      required this.prority,
      required this.status});

  Notes.fromMap(Map<String, dynamic> note)
      : id = note["id"],
        title = note["title"],
        body = note["body"],
        date = note["date"],
        color = note["color"],
        prority = note["priority"],
        status = note["status"];

  Map<String, Object?> toMap() {
    return {
      "id": id,
      "title": title,
      "body": body,
      "date": date,
      "color": color,
      "priority": prority,
      "status": status
    };
  }

}
