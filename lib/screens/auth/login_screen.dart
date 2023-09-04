import 'package:complete_store_with_admin_panel/screens/auth/register_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../consts/firebase_consts.dart';
import '../../widget/google_botton.dart';
import '../../widget/text_widget.dart';
import '../main_screen.dart';
import 'auth_dialog.dart';
import 'forget_password_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final formKey = GlobalKey<FormState>();
  bool obscureText = true;
  bool isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  void _submitFormOnLogin() async {
    final isValid = formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      setState(() {
        isLoading = true;
      });
      formKey.currentState!.save();
      try {
        await authInstance.signInWithEmailAndPassword(
          email: emailController.text.trim().toLowerCase(),
          password: passwordController.text.toLowerCase(),
        );
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MainScreen()));
      } on FirebaseException catch (error) {
        showAlertDialogRegister(
            context: context,
            text: 'An Error occured',
            contentText: '${error.code}');
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
          child: Form(
            key: formKey,
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
                  height: 8,
                ),
                TextWidget(
                  text: 'Sign in to Continue',
                  textSize: 18,
                  maxLines: 1,
                  isText: false,
                  color: Colors.black,
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                    textInputAction: TextInputAction.next,
                    onEditingComplete: () {
                      FocusScope.of(context).requestFocus(passwordFocusNode);
                    },
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'Please Enter your Valid';
                      } else {
                        return null;
                      }
                    },
                    decoration: const InputDecoration(
                      hintText: 'Email',
                      prefixIcon: Icon(Icons.email),
                      border: UnderlineInputBorder(),
                    )),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    controller: passwordController,
                    focusNode: passwordFocusNode,
                    textInputAction: TextInputAction.done,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'Please Enter your Valid';
                      } else {
                        return null;
                      }
                    },
                    obscureText: obscureText,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            obscureText = !obscureText;
                          });
                        },
                        icon: Icon(obscureText
                            ? Icons.remove_red_eye
                            : Icons.panorama_fish_eye),
                      ),
                      prefixIcon: const Icon(Icons.password),
                      border: const UnderlineInputBorder(),
                    )),
                const SizedBox(
                  height: 15,
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const ForgetPasswordScreen()));
                    },
                    child: TextWidget(
                      text: 'Forget Password?',
                      textSize: 18,
                      maxLines: 1,
                      isText: false,
                      color: Colors.deepPurple,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Center(
                  child: isLoading == true
                      ? const CircularProgressIndicator(
                          color: Colors.deepPurple,
                        )
                      : ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Colors.deepPurple.shade300),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              fixedSize: MaterialStateProperty.all(
                                  const Size(300, 35))),
                          onPressed: () {
                            _submitFormOnLogin();
                          },
                          child: TextWidget(
                              text: 'Sign in',
                              textSize: 18,
                              maxLines: 1,
                              isText: true,
                              color: Colors.white),
                        ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Center(
                  child: GoogleButton(),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    const Expanded(
                      child: Divider(
                        color: Colors.black,
                        height: 2,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    TextWidget(
                      text: 'OR',
                      textSize: 18,
                      maxLines: 1,
                      isText: false,
                      color: Colors.black,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const Expanded(
                      child: Divider(
                        color: Colors.black,
                        height: 2,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.black),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                        fixedSize:
                            MaterialStateProperty.all(const Size(300, 35))),
                    onPressed: () {
                      _submitFormOnLogin();
                    },
                    child: TextWidget(
                        text: 'Continue as a Guest',
                        textSize: 18,
                        maxLines: 1,
                        isText: true,
                        color: Colors.white),
                  ),
                ),
                Row(
                  children: [
                    TextWidget(
                      text: 'Don\'t have an account?',
                      textSize: 18,
                      maxLines: 1,
                      isText: false,
                      color: Colors.black,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const RegisterScreen()));
                      },
                      child: TextWidget(
                        text: 'Sign up',
                        textSize: 18,
                        maxLines: 1,
                        isText: false,
                        color: Colors.deepPurple,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
