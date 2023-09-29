import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseHelper {
  static FirebaseHelper firebaseHelper = FirebaseHelper._();

  FirebaseHelper._();

  FirebaseAuth auth = FirebaseAuth.instance;

  Future<String> guestSignIn() async {
    try {
      await auth.signInAnonymously();
      return "SignIn Successfully";
    } catch (e) {
      return "$e";
    }
  }

  bool checkUser() {
    User? user = auth.currentUser;
    return user != null;
  }

  Future<String> signInEmail(email, password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      return "SignIn Successfully";
    } catch (e) {
      return "$e";
    }
  }

  Future<String> signUpEmail(email, password) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return "SignUp Successfully";
    } catch (e) {
      return "$e";
    }
  }

  Future<UserCredential> signInGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
    await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<String> signOut() async {
    try {
      await auth.signOut();
      return "SignOut Successfully";
    } catch (e) {
      return "$e";
    }
  }

  Map<String, String?> userDetails() {
    User? user = auth.currentUser;

    return {
      "name": user!.displayName,
      "email": user.email,
      "phone": user.phoneNumber,
      "photo": user.photoURL,
    };
  }

  Future<String> signInWithGoogle() async {
    String? msg;
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
    await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    await FirebaseAuth.instance
        .signInWithCredential(credential)
        .then((value) => msg = "Success")
        .catchError((e) => msg = "$e");
    return msg!;
  }


//
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final GoogleSignIn googleSignIn = GoogleSignIn();
//
//   Future<User?> signInWithGoogle() async {
//     try {
//       final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
//       if (googleSignInAccount != null) {
//         final GoogleSignInAuthentication googleSignInAuthentication =
//         await googleSignInAccount.authentication;
//
//         final AuthCredential credential = GoogleAuthProvider.credential(
//           accessToken: googleSignInAuthentication.accessToken,
//           idToken: googleSignInAuthentication.idToken,
//         );
//
//         final UserCredential authResult = await _auth.signInWithCredential(credential);
//         final User? user = authResult.user;
//         return user;
//       }
//     } catch (error) {
//       print(error);
//       return null;
//     }
//
//
//
//
//
//
//
// // FirebaseFirestore firestore = FirebaseFirestore.instance;
//
// // Stream<QuerySnapshot<Map<String, dynamic>>> selectData() {
// //   return firestore.collection("products").snapshots();
// // }
// //
// // void updateData(ProductModel model) {
// //   firestore.collection("products").doc("${model.id}").set(
// //     {
// //       "name": model.name,
// //       "price": model.price,
// //       "category": model.cate,
// //       "description": model.desc,
// //       "image": model.img,
// //     },
// //   );
// // }
// }}

}