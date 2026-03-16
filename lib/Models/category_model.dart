class CategoryModel {
  final int? id;
  final String? title;

  CategoryModel({
    this.id,
    this.title,
  });

  CategoryModel copyWith({
    int? id,
    String? title,
  }) =>
      CategoryModel(
        id: id ?? this.id,
        title: title ?? this.title,
      );

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
    id: json["id"],
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
  };
}
