import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreTasksDataSource {
  final FirebaseFirestore _firestore;
  final String collectionPath;

  FirestoreTasksDataSource(this._firestore, {required this.collectionPath});

  CollectionReference<Map<String, dynamic>> get _collection =>
      _firestore.collection(collectionPath);

  Future<QuerySnapshot<Map<String, dynamic>>> getTasksForUser(String userId) {
    return _collection
        .where('user_id', isEqualTo: userId)
        .orderBy('created_at', descending: true)
        .get();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> watchTasksForUser(String userId) {
    return _collection
        .where('user_id', isEqualTo: userId)
        .orderBy('created_at', descending: true)
        .snapshots();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getTaskById(String taskId) {
    return _collection.doc(taskId).get();
  }

  Future<void> setTask(String taskId, Map<String, dynamic> data) {
    return _collection.doc(taskId).set(data);
  }

  Future<void> updateTask(String taskId, Map<String, dynamic> data) {
    return _collection.doc(taskId).update(data);
  }

  Future<void> deleteTask(String taskId) {
    return _collection.doc(taskId).delete();
  }
}
