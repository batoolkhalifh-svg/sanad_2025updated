import 'course_model.dart';

class HomeModel {
  final List<CourseModel> courses;
  final List<Slider> sliders;
  final List<Introduction> introductions;
  final List<VideoModel> videos;
  final List<Slider> banners;

  HomeModel({
    this.courses = const [],
    this.sliders = const [],
    this.introductions = const [],
    this.videos = const [],
    this.banners = const [],
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
    courses: json["courses"] == null ? [] : List<CourseModel>.from(json["courses"]!.map((x) => CourseModel.fromJson(x))),
    sliders: json["sliders"] == null ? [] : List<Slider>.from(json["sliders"]!.map((x) => Slider.fromJson(x))),
    banners: json["banners"] == null ? [] : List<Slider>.from(json["banners"]!.map((x) => Slider.fromJson(x))),
    introductions: json["introductions"] == null ? [] : List<Introduction>.from(json["introductions"]!.map((x) => Introduction.fromJson(x))),
    videos: json["videos"] == null ? [] : List<VideoModel>.from(json["videos"]!.map((x) => VideoModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "courses": List<dynamic>.from(courses.map((x) => x.toJson())),
    "sliders": List<dynamic>.from(sliders.map((x) => x.toJson())),
    "banners": List<dynamic>.from(sliders.map((x) => x.toJson())),
    "introductions": List<dynamic>.from(introductions.map((x) => x.toJson())),
    "videos": List<dynamic>.from(videos.map((x) => x.toJson())),
  };
}


class Introduction {
  final int? id;
  final String? title;

  Introduction({
    this.id,
    this.title,
  });

  factory Introduction.fromJson(Map<String, dynamic> json) => Introduction(
    id: json["id"],
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
  };
}

class Slider {
  final int? id;
  final String? image;

  Slider({
    this.id,
    this.image,
  });

  factory Slider.fromJson(Map<String, dynamic> json) => Slider(
    id: json["id"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "image": image,
  };
}

class VideoModel {
  final int? id;
  final String? video;
  final String? title;
  final String? image;

  VideoModel({
    this.id,
    this.video,
    this.title,
    this.image,
  });

  factory VideoModel.fromJson(Map<String, dynamic> json) => VideoModel(
    id: json["id"],
    video: json["video"],
    title: json["title"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "video": video,
    "title": title,
    "image": image,
  };
}
