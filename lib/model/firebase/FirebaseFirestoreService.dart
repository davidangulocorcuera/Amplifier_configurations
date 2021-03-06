import 'dart:async';
import 'dart:core';
import 'package:amplifier_configurations/model/Amplifier.dart';
import 'package:amplifier_configurations/model/Configuration.dart';
import 'package:amplifier_configurations/model/Musician.dart';
import 'package:amplifier_configurations/model/User.dart';
import 'package:async/async.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

CollectionReference musicianCollection =
    Firestore.instance.collection('musician');
CollectionReference usersCollection = Firestore.instance.collection('users');

class FirebaseFirestoreService {
  static final FirebaseFirestoreService _instance =
      new FirebaseFirestoreService.internal();

  factory FirebaseFirestoreService() => _instance;

  FirebaseFirestoreService.internal();

  // Insert User
  Future<User> createUser(
      List<String> favourites, String email, String uid) async {
    final TransactionHandler createTransaction = (Transaction tx) async {
      final DocumentSnapshot ds = await tx.get(usersCollection.document(uid));
      final User user = new User(favourites, email,uid);
      final Map<String, dynamic> data = user.toJson();
      await tx.set(ds.reference, data);
      return data;
    };
    return Firestore.instance.runTransaction(createTransaction).then((mapData) {
      return User.fromJson(mapData);
    }).catchError((error) {
      print('error: $error');
      return null;
    });
  }

  // Insert musician
  Future<Musician> createMusician(
      String id, String name, Configuration configuration, Amplifier amplifier) async {
    final TransactionHandler createTransaction = (Transaction tx) async {
      final DocumentSnapshot ds = await tx.get(musicianCollection.document());
      final Musician musician = new Musician(id, name, configuration, amplifier);
      final Map<String, dynamic> data = musician.toJson();
      await tx.set(ds.reference, data);
      return data;
    };
    return Firestore.instance.runTransaction(createTransaction).then((mapData) {
      return Musician.fromJson(mapData);
    }).catchError((error) {
      print('error: $error');
      return null;
    });
  }

// Get user
  Stream<QuerySnapshot> getUser(String uid, {int limit, int offset}) {
    Stream<QuerySnapshot> snapshots = usersCollection.where(
        "id", isEqualTo: uid).snapshots();

    if (offset != null) {
      snapshots = snapshots.skip(offset);
    }
    if (limit != null) {
      snapshots = snapshots.take(limit);
    }
    return snapshots;
  }

  StreamZip<QuerySnapshot> getFavouritesMusicians(List<String> ids, {int limit, int offset}) {
    List<Stream<QuerySnapshot>> streams = [];
    for (var id in ids) {
      Stream<QuerySnapshot> stream = musicianCollection.where('id', isEqualTo: id).snapshots();
      streams.add(stream);

      if (offset != null) {
        stream = stream.skip(offset);
      }
      if (limit != null) {
        stream = stream.take(limit);
      }
    }

    return StreamZip(streams);
  }

  // Get musicians
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
      final DocumentSnapshot ds =
          await tx.get(musicianCollection.document(musician.name));

      await tx.update(ds.reference, musician.toJson());
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
  // Update user
  Future<dynamic> updateUser(User user) async {
    final TransactionHandler updateTransaction = (Transaction tx) async {
      final DocumentSnapshot ds = await tx.get(usersCollection.document(user.id));
      await tx.update(ds.reference, user.toJson());
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
      final DocumentSnapshot ds =
          await tx.get(musicianCollection.document(name));

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
