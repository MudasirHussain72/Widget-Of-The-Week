import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginController with ChangeNotifier {
  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  // google sig  in
  Future<void> loginWithGoogle(BuildContext context) async {
    setLoading(true);
    // try {
    //   //To check internet connectivity
    //   await InternetAddress.lookup('firebase.google.com');
    //   final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    //   final GoogleSignInAuthentication? googleAuth =
    //       await googleUser?.authentication;
    //   if (googleAuth == null) {
    //     return;
    //   }
    //   final credential = GoogleAuthProvider.credential(
    //     accessToken: googleAuth.accessToken,
    //     idToken: googleAuth.idToken,
    //   );
    //   await auth.signInWithCredential(credential).then((value) async {
    //     SessionController().userId = value.user!.uid.toString();
    //     if (await userExists()) {
    //       Navigator.pushNamedAndRemoveUntil(
    //           context, RouteName.dashboardView, (route) => false);
    //       Utils.toastMessage("User login successfully");
    //       setLoading(false);
    //     } else {
    //       firestore.doc(value.user!.uid.toString()).set({
    //         'uid': value.user!.uid.toString(),
    //         'email': value.user!.email.toString(),
    //         'onlineStatus': 'noOne',
    //         'phone': '',
    //         'city': '',
    //         'address': '',
    //         'userName': value.user!.displayName,
    //         'profileImage': value.user!.photoURL,
    //         'userLocationLat': '',
    //         'userLocationLong': '',
    //       }).then((value) {
    //         // Navigator.pushNamed(context, RouteName.dashboardView);
    //         Navigator.pushNamedAndRemoveUntil(
    //             context, RouteName.dashboardView, (route) => false);
    //         Utils.toastMessage("User login successfully");
    //         setLoading(false);
    //       });
    //     }
    //   }).onError((error, stackTrace) {
    //     setLoading(false);
    //     Utils.toastMessage(error.toString());
    //   });
    // } catch (e) {
    //   setLoading(false);
    //   Utils.toastMessage(e.toString());
    //   if (kDebugMode) {
    //     print("Error: $e");
    //   }
    //   return;
    // }
  }
}
