import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todos/models/todo_model.dart';
import 'package:todos/utils/uuid_util.dart';

class TodosUtil {
  add(String text) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    await firestore.collection('todos').add(TodoModel(
          await UuidUtil().get(),
          text,
          false,
        ).toMap());
  }
}
