class TodoModel {
  final String uuid;
  final String text;
  final bool done;

  TodoModel(this.uuid, this.text, this.done);

  toMap() {
    return {
      'uuid': uuid,
      'text': text,
      'done': done,
    };
  }
}
