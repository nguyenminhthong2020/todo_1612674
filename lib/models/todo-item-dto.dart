// ignore_for_file: file_names

class TodoItemModel {
  TodoItemModel(
      this.id, this.title, this.description, this.date, this.time, this.isDone);
  final int id;
  String title;
  String description;
  String date;
  String time;
  bool isDone;

  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "title": this.title,
      "description": this.description,
      "date": this.date,
      "time": this.time,
      "isDone": this.isDone
    };
  }

  factory TodoItemModel.fromJson(dynamic json) {
    return TodoItemModel(
        json['id'] as int,
        json['title'] as String,
        json['description'] as String,
        json['date'] as String,
        json['time'] as String,
        json['isDone'] as bool);
  }
}
