import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import '../consts/firebase_consts.dart';
import '../widget/text_widget.dart';
import 'auth/forget_password_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
  bool editable = true;

  String name = '';
  String email = '';
  String shippingAddress = '';

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

  @override
  void initState() {
    setState(() {
      emailController.text = email;
      nameController.text = name;
      addersController.text = shippingAddress;
    });
    getUserData();

    super.initState();
  }

  void getUserData() async {
    final User? user = authInstance.currentUser;
    final _uid = user!.uid;
    final DocumentSnapshot userSnapshot =
        await fireStore.collection('users').doc(_uid).get();
    if (userSnapshot == null) {
      return;
    } else {
      setState(() {
        nameController.text = userSnapshot.get('userName');
        emailController.text = userSnapshot.get('email');
        addersController.text = userSnapshot.get('shipping_address');
      });
    }
  }

  updateUserData() async {
    EasyLoading.show();
    final User? user = authInstance.currentUser;
    final _uid = user!.uid;
    if (formKey.currentState!.validate()) {
      return await fireStore.collection('users').doc(_uid).update({
        'userName': nameController.text,
        'email': emailController.text,
        'shipping_address': addersController.text,
      }).then((value) {
        setState(() {
          editable = true;
        });
        EasyLoading.dismiss();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          elevation: 0,
          title: TextWidget(
            text: 'Your Profile',
            textSize: 25,
            maxLines: 1,
            isText: true,
            color: Colors.white,
          ),
          actions: [
            editable
                ? IconButton(
                onPressed: () {
                  setState(() {
                    editable = false;
                  });
                },
                icon: const Icon(
                  Icons.edit,
                  color: Colors.white,
                  size: 30,
                ))
                : TextButton(
              onPressed: () {
                updateUserData();
              },
              child: TextWidget(
                text: 'Save',
                textSize: 20,
                maxLines: 1,
                isText: true,
                color: Colors.red,
              ),
            )
          ],
        ),

        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: AbsorbPointer(
              absorbing: editable,
              child: Column(
                children: [

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
                          return 'Plase Ener your Vaild';
                        }
                      },
                      decoration: InputDecoration(
                        filled: editable ? true : false,
                        fillColor:
                            editable ? Colors.deepPurple.shade50 : Colors.white,
                        prefixIcon: const Icon(Icons.edit),
                        border: const OutlineInputBorder(),
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
                        }
                      },
                      decoration: InputDecoration(
                        filled: editable ? true : false,
                        fillColor:
                            editable ? Colors.deepPurple.shade50 : Colors.white,
                        prefixIcon: const Icon(Icons.email),
                        border: const OutlineInputBorder(),
                      )),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                      keyboardType: TextInputType.text,
                      controller: addersController,
                      textInputAction: TextInputAction.done,
                      focusNode: addersFocusNode,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Please Enter your Valid';
                        }
                      },
                      decoration: InputDecoration(
                        filled: editable ? true : false,
                        fillColor:
                            editable ? Colors.deepPurple.shade50 : Colors.white,
                        prefixIcon: const Icon(Icons.shopping_cart),
                        border: const OutlineInputBorder(),
                      )),
                  const SizedBox(
                    height: 15,
                  ),
                  ListTitleWidget2(
                      leading: IconlyBold.unlock,
                      title: 'Forget Password',
                      trailing: IconlyLight.arrowRightCircle,
                      ontap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ForgetPasswordScreen()));
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget ListTitleWidget2(
      {required String title,
      IconData? leading,
      IconData? trailing,
      required Function ontap}) {
    return ListTile(
      leading: Icon(
        leading,
        size: 30,
      ),
      title: TextWidget(
        text: title,
        textSize: 22,
        maxLines: 1,
        color: Colors.black,
        isText: true,
      ),
      trailing: Icon(trailing),
      onTap: () => ontap(),
    );
  }
}
