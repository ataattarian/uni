class Category {
  int id;
  String name;

  Category(
    this.id,
    this.name,
  );

  factory Category.fromJson(Map<String, dynamic> json) =>
      Category(json['id'], json['name']);
}
