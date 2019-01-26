import 'dart:async';
import 'package:amplifier_configurations/model/Amplifier.dart';
import 'package:amplifier_configurations/model/Configuration.dart';
import 'package:amplifier_configurations/model/Musician.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final CollectionReference musicianCollection =
    Firestore.instance.collection('musician');

class FirebaseFirestoreService {
  static final FirebaseFirestoreService _instance =
      new FirebaseFirestoreService();

  factory FirebaseFirestoreService() => _instance;

  FirebaseFirestoreService.internal();

  // Insert musician
  Future<Musician> createMusician(
      String name, Configuration configuration, Amplifier amplifier) async {
    final TransactionHandler createTransaction = (Transaction tx) async {
      final DocumentSnapshot ds = await tx.get(musicianCollection.document());
      final Musician musician = new Musician(name, configuration, amplifier);
      final Map<String, dynamic> data = musician.toMap();
      await tx.set(ds.reference, data);
      return data;
    };
    return Firestore.instance.runTransaction(createTransaction).then((mapData) {
      return Musician.fromMap(mapData);
    }).catchError((error) {
      print('error: $error');
      return null;
    });
  }

  // Get musician
  Stream<QuerySnapshot> getMusiciansList({int offset, int limit}) {
    Stream<QuerySnapshot> snapshots = musicianCollection.snapshots();

    if (offset != null) {
      snapshots = snapshots.skip(offset);
    }

    if (limit != null) {
      snapshots = snapshots.take(limit);
    }

    return snapshots;
  }
  // Update musician
  Future<dynamic> updateMusician(Musician musician) async {
    final TransactionHandler updateTransaction = (Transaction tx) async {
      final DocumentSnapshot ds = await tx.get(musicianCollection.document(musician.name));

      await tx.update(ds.reference, musician.toMap());
      return {'updated': true};
    };

    return Firestore.instance
        .runTransaction(updateTransaction)
        .then((result) => result['updated'])
        .catchError((error) {
      print('error: $error');
      return false;
    });
  }

  Future<dynamic> deleteMusician(String name) async {
    final TransactionHandler deleteTransaction = (Transaction tx) async {
      final DocumentSnapshot ds = await tx.get(musicianCollection.document(name));

      await tx.delete(ds.reference);
      return {'deleted': true};
    };

    return Firestore.instance
        .runTransaction(deleteTransaction)
        .then((result) => result['deleted'])
        .catchError((error) {
      print('error: $error');
      return false;
    });
  }

}
