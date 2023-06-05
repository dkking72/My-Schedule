import 'package:my_schedule/src_exports.dart';

class TaskModel {
  String docId;
  String title;
  String detail;
  DateTime date;
  bool urgent;
  String uid;

  TaskModel(
      {this.title = "",
      this.detail = "",
      required this.date,
      this.urgent = false,
      this.docId = '',
      this.uid = ''});

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
        title: json['title'] ?? "",
        detail: json['detail'] ?? "",
        date: json['date'] != null
            ? (json['date'] as Timestamp).toDate()
            : DateTime(0),
        urgent: json['urgent'] ?? false,
        uid: json['uid'] ?? "");
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['detail'] = detail;
    data['date'] = date.year == 0 ? null : Timestamp.fromDate(date);
    data['urgent'] = urgent;
    data['uid'] = FirebaseAuth.instance.currentUser!.uid;
    return data;
  }
}
