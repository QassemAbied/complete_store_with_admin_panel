import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../widget/text_widget.dart';
import '../../consts/firebase_consts.dart';
import 'auth_dialog.dart';
import 'forget_password_screen.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController addersController = TextEditingController();

  final FocusNode nameFocusNode = FocusNode();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode addersFocusNode = FocusNode();

  final formKey = GlobalKey<FormState>();
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;
  bool obscureText = true;
  bool isLoading = false;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    addersController.dispose();
    nameFocusNode.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    addersFocusNode.dispose();
    super.dispose();
  }

  void _submitFormOnLogin() async {
    final isValid = formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      setState(() {
        isLoading = true;
      });
      try {
        formKey.currentState!.save();

        await authInstance.createUserWithEmailAndPassword(
          email: emailController.text.toLowerCase().trim(),
          password: passwordController.text.trim(),
        );
        final User? user = authInstance.currentUser;
        final _uid = user!.uid;
        user.updateDisplayName(nameController.text);
        user.reload();
        await fireStore.collection('users').doc(_uid).set({
          'id': _uid,
          'userName': nameController.text,
          'email': emailController.text,
          'shipping_address': addersController.text,
          'user_wish': [],
          'user_cart': [],
          'createAt': Timestamp.now(),
        });
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginScreen()));
        // print('sccufly register');
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
                  text: 'Sign Up to Continue',
                  textSize: 18,
                  maxLines: 1,
                  isText: false,
                  color: Colors.black,
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                    keyboardType: TextInputType.name,
                    controller: nameController,
                    textInputAction: TextInputAction.next,
                    onEditingComplete: () {
                      FocusScope.of(context).requestFocus(emailFocusNode);
                    },
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'Please Enter your Valid';
                      } else {
                        return null;
                      }
                    },
                    decoration: const InputDecoration(
                      hintText: 'Full Name',
                      prefixIcon: Icon(Icons.edit),
                      border: UnderlineInputBorder(),
                    )),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                    textInputAction: TextInputAction.next,
                    focusNode: emailFocusNode,
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
                    textInputAction: TextInputAction.next,
                    onEditingComplete: () {
                      FocusScope.of(context).requestFocus(addersFocusNode);
                    },
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
                  height: 30,
                ),
                TextFormField(
                    keyboardType: TextInputType.text,
                    controller: addersController,
                    textInputAction: TextInputAction.done,
                    focusNode: addersFocusNode,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'Please Enter your Valid';
                      } else {
                        return null;
                      }
                    },
                    decoration: const InputDecoration(
                      hintText: 'Shopping Adders',
                      prefixIcon: Icon(Icons.shopping_cart),
                      border: UnderlineInputBorder(),
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
                              text: 'Sign Up',
                              textSize: 18,
                              maxLines: 1,
                              isText: true,
                              color: Colors.white),
                        ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    TextWidget(
                      text: 'Already a User?',
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
                                builder: (context) => const LoginScreen()));
                      },
                      child: TextWidget(
                        text: 'Sign in',
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
