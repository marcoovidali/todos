class TodoModel {
  const TodoModel(
    this.uuid,
    this.text,
    this.done,
  );

  final String uuid;
  final String text;
  final bool done;

  Map<String, dynamic> toMap() {
    return {
      'uuid': uuid,
      'text': text,
      'done': done,
    };
  }
}
