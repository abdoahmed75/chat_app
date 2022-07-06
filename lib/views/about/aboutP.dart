import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/routes/app_routes.dart';
import 'package:get/get.dart';
class AboutP extends StatefulWidget {
  @override
  State<AboutP> createState() => _AboutPState();
}

class _AboutPState extends State<AboutP> {
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0,vertical: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                    height: h*.2,
                    width: double.infinity,
                    child: Image.asset('assets/images/icon.jpeg',)),

                  SizedBox(
                      height: h*.2,
                      width: double.infinity,
                      child:Text("It is an application whose purpose is to provide assistance in several things, which is if you lose something that helps you retrieve it or find something that helps you to reach the owner of the thing or get a job or offer a job and provide financial aid to the needy or those who want to help and deliver things and it is based on helping people to each other",
                        style: TextStyle(color:Colors.black,fontSize: 13.0,fontWeight:FontWeight.bold, ),

                      )

                  ),
                SizedBox(
                  height: h*.05,
                  width:double.infinity,
                  child:   RaisedButton(
                    color: Colors.green,
                    onPressed: (){
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Text('الخدمات المقدمه',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: w*.05,
                      ),


                    ),
                  ),
                ),
                SizedBox(
                  height: h*.05,
                  width:double.infinity,
                  child:   RaisedButton(
                    color: Colors.green,
                    onPressed: (){
                      Get.toNamed(Routes.CONTROL);
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Text('خدمات عامه',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: w*.05,
                      ),


                    ),
                  ),
                ),
                SizedBox(
                  height: h*.05,
                  width:double.infinity,
                  child:   RaisedButton(
                    color: Colors.green,
                    onPressed: (){
                      Get.toNamed(Routes.mafcodAbout);
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Text('المفقودات',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: w*.05,
                      ),


                    ),
                  ),
                ),

                SizedBox(
                    height: h*.05,
                    width:double.infinity,
                    child:   RaisedButton(
                      color: Colors.green,
                      onPressed: (){
                        Get.toNamed(Routes.jobAbout);
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Text('الوظائف',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: w*.05,
                        ),),)),
                SizedBox(
                    height: h*.05,
                    width:double.infinity,
                    child:   RaisedButton(
                      color: Colors.green,
                      onPressed: (){
                        Get.toNamed(Routes.deliverAbout);
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Text('توصيل طلبات',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: w*.05,
                        ),),)),
                SizedBox(
                    height: h*.05,
                    width:double.infinity,
                    child:   RaisedButton(
                      color: Colors.green,
                      onPressed: (){
                        Get.toNamed(Routes.helpAbout);
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Text('مساعدات ماليه',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: w*.05,
                        ),),)),

              ],

            ),
          ),
        ),
      );


  }
}
