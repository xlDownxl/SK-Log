import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../lib/models/user.dart';
import '../lib/flutterLogin/flutter_login.dart' as ld;
import '../lib/models/analysen.dart';

void dao() async {
  var id;
  await FirebaseAuth.instance.createUserWithEmailAndPassword(email: "aaasd@asd.de", password: "123456")
      .then((user) {
    id = user.user.uid;
    FirebaseAuth.instance.signOut();
    return FirebaseAuth.instance
        .createUserWithEmailAndPassword(
        email: "asaaasd@asd.de", password: "123456")
        .then((user) {
      print("lel");
      expect(1, -1);
    });
  });
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  var user=AppUser();
  test('currentUser', () async {
    expect(user.handle_auth(ld.LoginData(
      name: "dfdsfsfd@asddsad.de",
      password: "123456",
    ), Analysen(), null),throws);
  });
  test('LoginWorks', () async {
    expect(user.handle_auth(ld.LoginData(
      name: "qwe@qwe.de",
      password: "123456",
    ), Analysen(), null),completes);
  });
}
