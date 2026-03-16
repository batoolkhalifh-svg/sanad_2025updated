
class NotificationModel {
  final int? id;
  final String? title;
  final String? date;
  final String? time;

  NotificationModel({
    this.id,
    this.title,
    this.date,
    this.time,
  });

  NotificationModel copyWith({
    int? id,
    String? title,
    String? date,
    String? time,
  }) =>
      NotificationModel(
        id: id ?? this.id,
        title: title ?? this.title,
        date: date ?? this.date,
        time: time ?? this.time,
      );

  factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
    id: json["id"],
    title: json["title"],
    date: json["date"],
    time: json["time"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "date": date,
    "time": time,
  };
}
