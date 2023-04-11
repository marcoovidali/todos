import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todos/models/todo_model.dart';
import 'package:todos/utils/uuid_util.dart';

class TodoUtil {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> add(String text) async {
    await firestore.collection('todos').add(
          TodoModel(
            await UuidUtil().get(),
            text,
            false,
            DateTime.now(),
          ).toMap(),
        );
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getAll() async {
    return await firestore
        .collection('todos')
        .where('uuid', isEqualTo: await UuidUtil().get())
        .orderBy('timestamp', descending: true)
        .get();
  }

  void delete(String docId) async {
    await firestore.collection('todos').doc(docId).delete();
  }
}
