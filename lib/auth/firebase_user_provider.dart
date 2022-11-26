import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class AcademiaDelSaberFirebaseUser {
  AcademiaDelSaberFirebaseUser(this.user);
  User? user;
  bool get loggedIn => user != null;
}

AcademiaDelSaberFirebaseUser? currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<AcademiaDelSaberFirebaseUser> academiaDelSaberFirebaseUserStream() =>
    FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(user))
        .map<AcademiaDelSaberFirebaseUser>(
      (user) {
        currentUser = AcademiaDelSaberFirebaseUser(user);
        return currentUser!;
      },
    );
