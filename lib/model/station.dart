class Station {
  Station({this.id, this.name, this.source});

  final int id;
  final String name;
  final String source;

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "source": source,
    };
  }

  @override
  String toString() {
    return "Stations {id:$id, name:$name, source:$source}";
  }
}
