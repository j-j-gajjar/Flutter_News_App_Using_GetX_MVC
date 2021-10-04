class Source {
  Source({required this.id, required this.name});

  final String id;
  final String name;

  factory Source.fromJson(Map<String, dynamic> json) =>
      Source(id: json["id"] == null ? '' : json["id"], name: json["name"] == null ? '' : json["name"]);
}
