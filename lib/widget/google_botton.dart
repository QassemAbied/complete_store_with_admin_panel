import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:complete_store_with_admin_panel/widget/text_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../consts/firebase_consts.dart';
import '../data_screen.dart';
import '../screens/auth/auth_dialog.dart';

class GoogleButton extends StatefulWidget {
  const GoogleButton({super.key});

  @override
  State<GoogleButton> createState() => _GoogleButtonState();
}

class _GoogleButtonState extends State<GoogleButton> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.deepPurple.shade300,
      child: InkWell(
        onTap: () {
          googleSignIn();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image(
              image: AssetImage('assets/images/55.png'),
              width: 40.0,
            ),
            TextWidget(
                text: 'Sign in With Google',
                textSize: 18,
                maxLines: 1,
                isText: true,
                color: Colors.white),
          ],
        ),
      ),
    );
  }

  Future googleSignIn() async {
    final googleSignIn = GoogleSignIn();
    final googleAccount = await googleSignIn.signIn();
    if (googleSignIn != null) {
      final googleAuth = await googleAccount?.authentication;
      if (googleAuth!.accessToken != null && googleAuth.idToken != null) {
        try {
          final authResult = await authInstance.signInWithCredential(
            GoogleAuthProvider.credential(
                accessToken: googleAuth.accessToken,
                idToken: googleAuth.idToken),
          );
          if (authResult.additionalUserInfo!.isNewUser) {
            await FirebaseFirestore.instance
                .collection('users')
                .doc(authResult.user!.uid)
                .set({
              'id': authResult.user!.uid,
              'userName': authResult.user!.displayName,
              'email': authResult.user!.email,
              'shipping_address': 'addersController.text',
              'user_wish': [],
              'user_cart': [],
              'createAt': Timestamp.now(),
            });
          }
          // Navigator.pushReplacement(
          //     context, MaterialPageRoute(builder: (context) => DataScreen()));
        } on FirebaseException catch (error) {
          showAlertDialogRegister(
              context: context,
              text: 'An Error occured',
              contentText: '${error.message}');
        } catch (error) {
          showAlertDialogRegister(
              context: context,
              text: 'An Error occured',
              contentText: '$error');
        }
      }
    }
  }
}
