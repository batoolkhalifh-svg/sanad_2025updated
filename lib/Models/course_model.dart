import 'package:sanad_2025/Models/user_model.dart';
import 'package:sanad_2025/Utilities/strings.dart';
import 'package:sanad_2025/core/Language/locales.dart';
import 'category_model.dart';

class CourseModel {
  final int? id;
  final int? categoryId;
  final String? title;
  final String? description;
  final DateTime? date;
  final String? time;
  final String? duration;
  final String? language;
  final int? payed;
  final int? price;
  final String? image;
  final String? video;
  final String? meetingUrl;
  final UserModel? instructor;
  final CategoryModel? categories;
  final List<CourseInfo> requirements;
  final List<CourseInfo> subtitle;
  final int? courseJoined;
  final bool userJoined;
  final String? currency;
  final String? courseTypeAr;
  final String? courseTypeEn;

  String get priceWithCurrency => (price??0) == 0?Strings.free.tr: "${price??0} ${currency??""}";

  CourseModel({
    this.id,
    this.categoryId,
    this.title,
    this.description,
    this.date,
    this.time,
    this.duration,
    this.language,
    this.payed,
    this.price,
    this.image,
    this.video,
    this.meetingUrl,
    this.instructor,
    this.categories,
    this.requirements = const [],
    this.subtitle = const [],
    this.courseJoined,
    this.userJoined = false,
    this.currency,
    this.courseTypeAr,
    this.courseTypeEn,
  });

  CourseModel copyWith({
    int? id,
    int? categoryId,
    String? currency,
    String? title,
    String? description,
    DateTime? date,
    String? time,
    String? duration,
    String? language,
    int? payed,
    int? price,
    String? image,
    String? video,
    String? meetingUrl,
    UserModel? instructor,
    String? instructorImage,
    CategoryModel? categories,
    List<CourseInfo>? requirements,
    List<CourseInfo>? subtitle,
    int? courseJoined,
    bool? userJoined,
  }) =>
      CourseModel(
        id: id ?? this.id,
        categoryId: categoryId ?? this.categoryId,
        title: title ?? this.title,
        description: description ?? this.description,
        date: date ?? this.date,
        time: time ?? this.time,
        duration: duration ?? this.duration,
        language: language ?? this.language,
        payed: payed ?? this.payed,
        price: price ?? this.price,
        image: image ?? this.image,
        video: video ?? this.video,
        meetingUrl: meetingUrl ?? this.meetingUrl,
        instructor: instructor ?? this.instructor,
        categories: categories ?? this.categories,
        requirements: requirements ?? this.requirements,
        subtitle: subtitle ?? this.subtitle,
        courseJoined: courseJoined ?? this.courseJoined,
        userJoined: userJoined ?? this.userJoined,
        currency: currency ?? this.currency,
      );

  factory CourseModel.fromJson(Map<String, dynamic> json) => CourseModel(
    id: json["id"],
    categoryId: json["category_id"],
    title: json["title"],
    description: json["description_"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    time: json["time"],
    duration: json["duration"],
    language: json["language"],
    payed: json["payed"],
    price: json["price"],
    image: json["image"],
    video: json["video"],
    meetingUrl: json["meeting_url"],
    instructor: json["instructor"] == null ? null : UserModel.fromJson(json["instructor"]..["photo"] = json["instructor_image"]),
    categories: json["categories"] == null ? null : CategoryModel.fromJson(json["categories"]),
    requirements: json["requirements"] == null ? [] : List<CourseInfo>.from(json["requirements"]!.map((x) => CourseInfo.fromJson(x))),
    subtitle: json["subtitle"] == null ? [] : List<CourseInfo>.from(json["subtitle"]!.map((x) => CourseInfo.fromJson(x))),
    courseJoined: json["course_joined"],
    userJoined: json["user_joined"],
    currency: json["currency"],
    courseTypeAr: json["course_type_ar"] ?? "غير محدد",
    courseTypeEn: json["course_type_en"] ?? "Not set",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "category_id": categoryId,
    "title": title,
    "description_": description,
    "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
    "time": time,
    "duration": duration,
    "language": language,
    "payed": payed,
    "price": price,
    "image": image,
    "video": video,
    "meeting_url": meetingUrl,
    "instructor": instructor?.toJson(),
    "categories": categories?.toJson(),
    "requirements": List<dynamic>.from(requirements.map((x) => x.toJson())),
    "subtitle": List<dynamic>.from(subtitle.map((x) => x.toJson())),
    "course_joined": courseJoined,
    "user_joined": userJoined,
    "currency": currency,
    "course_type_ar": courseTypeAr,
    "course_type_en": courseTypeEn,
  };
}

class CourseInfo {
  final int? id;
  final int? courseId;
  final String? name;

  CourseInfo({
    this.id,
    this.courseId,
    this.name,
  });

  CourseInfo copyWith({
    int? id,
    int? courseId,
    String? name,
  }) =>
      CourseInfo(
        id: id ?? this.id,
        courseId: courseId ?? this.courseId,
        name: name ?? this.name,
      );

  factory CourseInfo.fromJson(Map<String, dynamic> json) => CourseInfo(
    id: json["id"],
    courseId: json["course_id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "course_id": courseId,
    "name": name,
  };
}
