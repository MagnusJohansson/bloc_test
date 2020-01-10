class Folder {
  Folder(this.id, this.name, this.childCount,
      [this.children = const <Folder>[]]);

  final int id;
  final String name;
  final int childCount;
  final List<Folder> children;

  @override
  String toString() {
    return "Folder {id:$id, name:$name, childCount:$childCount}";
  }
}
