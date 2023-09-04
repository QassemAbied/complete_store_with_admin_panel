import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../widget/text_widget.dart';
import '../../consts/firebase_consts.dart';
import 'auth_dialog.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final TextEditingController emailController = TextEditingController();

  final FocusNode emailFocusNode = FocusNode();

  bool obscureText = true;

  @override
  void dispose() {
    emailController.dispose();
    emailFocusNode.dispose();
    super.dispose();
  }

  bool isLoading = false;
  void _forgetPassword() async {
    FocusScope.of(context).unfocus();
    if (emailController.text.isEmpty || !emailController.text.contains('@')) {
      showAlertDialogRegister(
          context: context,
          text: 'An Error occurred',
          contentText: 'please enter the correct email in form');
    } else {
      try {
        setState(() {
          isLoading = true;
        });
        await authInstance.sendPasswordResetEmail(
          email: emailController.text.toLowerCase(),
        );
        Fluttertoast.showToast(
            msg: "An Email has been Sent To Your Email Adders",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.deepPurple.shade50,
            textColor: Colors.white,
            fontSize: 20.0);
      } on FirebaseException catch (error) {
        showAlertDialogRegister(
            context: context,
            text: 'An Error occured',
            contentText: '${error.message}');
        setState(() {
          isLoading = false;
        });
      } catch (error) {
        showAlertDialogRegister(
            context: context, text: 'An Error occured', contentText: '$error');
        setState(() {
          isLoading = false;
        });
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 50, left: 10, right: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget(
                text: 'Welcome Back',
                textSize: 28,
                maxLines: 1,
                isText: true,
                color: Colors.black,
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                  textInputAction: TextInputAction.done,
                  focusNode: emailFocusNode,
                  decoration: const InputDecoration(
                    hintText: 'Email',
                    prefixIcon: Icon(Icons.email),
                    border: UnderlineInputBorder(),
                  )),
              const SizedBox(
                height: 30,
              ),
              Center(
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.deepPurple.shade300),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      fixedSize:
                          MaterialStateProperty.all(const Size(300, 35))),
                  onPressed: () {
                    _forgetPassword();
                  },
                  child: TextWidget(
                      text: 'Rest Now',
                      textSize: 18,
                      maxLines: 1,
                      isText: true,
                      color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
