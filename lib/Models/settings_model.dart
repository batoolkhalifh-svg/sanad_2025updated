import 'dart:convert';


class SettingsModel {
  final int? id;
  final String? name;
  final String? title;
  final String? desc;
  final String? phone;
  final String? mail;
  final String? logo;
  final String? image;
  final String? favicon;

  final String? twitter;
  final String? facebook;
  final String? linkedin;
  final String? instagram;
  final String? whatsapp;

  SettingsModel({
    this.id,
    this.name,
    this.title,
    this.desc,
    this.phone,
    this.mail,
    this.logo,
    this.image,
    this.favicon,
    this.twitter,
    this.facebook,
    this.instagram,
    this.whatsapp,
    this.linkedin,
  });

  factory SettingsModel.fromRawJson(String str) => SettingsModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SettingsModel.fromJson(Map<String, dynamic> json) => SettingsModel(
    id: json["id"],
    name: json["name"],
    title: json["title"],
    desc: json["desc"],
    phone: json["phone"],
    mail: json["mail"],
    logo: (json["logo"] != null && json["logo"].toString().isNotEmpty)
        ? json["logo"]
        : 'https://via.placeholder.com/150',
    image: (json["image"] != null && json["image"].toString().isNotEmpty)
        ? json["image"]
        : 'https://via.placeholder.com/300',
    favicon: (json["favicon"] != null && json["favicon"].toString().isNotEmpty)
        ? json["favicon"]
        : 'https://via.placeholder.com/50',
    twitter: json["twitter"],
    facebook: json["facebook"],
    instagram: json["instagram"],
    whatsapp: json["whatsapp"],
    linkedin: json["linkedin"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "title": title,
    "desc": desc,
    "phone": phone,
    "mail": mail,
    "logo": logo,
    "image": image,
    "favicon": favicon,
    "twitter": twitter,
    "facebook": facebook,
    "instagram": instagram,
    "whatsapp": whatsapp,
    "linkedin": linkedin,
  };
}
