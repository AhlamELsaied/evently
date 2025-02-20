import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/core/maneger/firebase/model/eventfiremodel.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseDatabase {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  static CollectionReference<EventModel> getRaf() {
    return firestore.collection("evently").withConverter<EventModel>(
      fromFirestore: (snapshot, options) {
        return EventModel.fromJson(snapshot.data()!);
      },
      toFirestore: (value, options) {
        return value.toJson();
      },
    );
  }

  static Future<void> addEvent(EventModel data) async {
    var ref = getRaf();
    var doc = ref.doc();
    data.id = doc.id;
    return doc.set(data);
  }

  static Future<void> updateFavoriteStatus(EventModel data) async {
    await getRaf().doc(data.id).update({"isFav": data.isFav});
  }

  static Future<List<QueryDocumentSnapshot<EventModel>>> getEvent() async {
    var ref = getRaf()
        .where("userId", isEqualTo: FirebaseAuth.instance.currentUser!.uid);
    var data = await ref.get();
    return data.docs;
  }

  static Stream<QuerySnapshot<EventModel>> getEventStream(String category) {
    var ref = category == "All"
        ? getRaf()
            .where("userId", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        : getRaf()
            .where("userId", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .where("categoryId", isEqualTo: category);
    return ref.snapshots();
  }

  static Stream<QuerySnapshot<EventModel>> getFavStream() {
    var ref = getRaf()
        .where("userId", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .where("isFav", isEqualTo: true);
    return ref.snapshots();
  }

  static Future<void> deleteData(String id) async {
    await getRaf().doc(id).delete();
  }

  static Future<void> updateEvent(EventModel eventModel) async {
    await getRaf().doc(eventModel.id).update(eventModel.toJson());
  }
}
