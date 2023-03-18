class ListModel {
  final String id;
  final String title;

  ListModel({required this.id, required this.title});
  @override
  String toString() {
    return 'id:$id title:$title';
  }
}
