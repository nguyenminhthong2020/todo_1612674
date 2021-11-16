// ignore_for_file: file_names

class TodoItemModel {
  TodoItemModel(this.id, this.title, this.description, this.date, this.time, this.isDone);
  final int id;
  final String title;
  final String description;
  final String date;
  final String time;
  final bool isDone;
}