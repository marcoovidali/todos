class TodoModel {
  const TodoModel(this.uuid, this.text, this.done, this.timestamp);

  final String uuid;
  final String text;
  final bool done;
  final DateTime timestamp;

  Map<String, dynamic> toMap() {
    return {
      'uuid': uuid,
      'text': text,
      'done': done,
      'timestamp': timestamp,
    };
  }
}
