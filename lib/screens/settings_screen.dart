import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:complete_store_with_admin_panel/screens/profile_screen.dart';
import 'package:complete_store_with_admin_panel/screens/viewed/viewed_recently_screen.dart';
import 'package:complete_store_with_admin_panel/screens/watchlist/watchlist_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import '../consts/firebase_consts.dart';
import '../user_state.dart';
import '../widget/show Dialog.dart';
import '../widget/text_widget.dart';
import 'auth/login_screen.dart';
import 'order/order_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool SelectDark= false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10,top: 10, bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  TextButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfileScreen()));
                    },
                    child: TextWidget(
                      text: 'Profile',
                      textSize: 22,
                      maxLines: 1,
                      isText: true,
                      color: Colors.red,
                    ),
                  ),

                ],
              ),
            ),
            Divider(color: Colors.black38,),
            ListTitleWidget2(
              leading: IconlyBold.bag,
              title: 'Order',
              trailing: IconlyLight.arrowRightCircle,
              ontap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>OrderScreen()));
              }

            ),
            ListTitleWidget2(
              leading: IconlyBold.heart,
              title: 'WatchList',
              trailing: IconlyLight.arrowRightCircle,
                ontap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>WatchlistScreen()));
                }
            ),
            ListTitleWidget2(
              leading: IconlyBold.show,
              title: 'Viewed',
              trailing: IconlyLight.arrowRightCircle,
                ontap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>const ViewedRecentlyScreen()));

                }
            ),

            SwitchListTile(
              title:TextWidget(
                text: 'Dark Mode',
                textSize: 22,
                maxLines: 1,
                color: Colors.black,
                isText: true,
              ),
                secondary: Icon(SelectDark? Icons.dark_mode : Icons.light_mode ,  size: 30,),
                activeColor: Colors.deepPurple,
                value: SelectDark,
                onChanged: (value){
                  setState(() {
                    SelectDark= value;
                  });
                }
            ),
            ListTitleWidget2(
              leading: IconlyBold.logout,
              title: 'Logout',
              trailing: IconlyLight.arrowRightCircle,
                ontap: ()async{
                await showAlertDialog(
                  context: context,
                  text: 'LogOut?',
                    contentText: 'Do you Wanna Sign Out?',
                    ftx: ()async{


                      await FirebaseAuth.instance.signOut();

                      Navigator.pop(context);
                       Navigator.pushReplacement(context,
                           MaterialPageRoute(builder: (context)=> UserState()),
                       );

    },
                    bottomText: 'Ok',
                  nextBottom: true,
                );
                }
            ),

          ],
        ),
      ),
    );
  }

  Widget ListTitleWidget(
      {required String subtitle,required String title, IconData? leading, IconData? trailing, required Function ontap }) {
    return ListTile(
      leading: Icon(leading, size: 30,),

      title:TextWidget(
          text: title,
          textSize: 22,
          maxLines: 1,
          color: Colors.black,
        isText: true,
      ),
      subtitle:TextWidget(
        text: subtitle,
        textSize: 19,
        maxLines: 1,
        color: Colors.black38,
        isText: false,
      ),
      trailing: Icon(trailing),
      onTap: ()=>ontap(),

    );
  }

  Widget ListTitleWidget2(
      {required String title, IconData? leading, IconData? trailing, required Function ontap }) {
    return ListTile(
      leading: Icon(leading, size: 30,),

      title: TextWidget(
        text: title,
        textSize: 22,
        maxLines: 1,
        color: Colors.black,
        isText: true,
      ),
      trailing: Icon(trailing),
      onTap: ()=>ontap(),
    );
  }

}