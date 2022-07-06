import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/routes/app_routes.dart';
import 'package:get/get.dart';
class jobAbout extends StatefulWidget {
  @override
  State<jobAbout> createState() => _jobAboutState();
}

class _jobAboutState extends State<jobAbout> {
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
                  height: h*.4,
                  width: double.infinity,
                  child: Image.asset('assets/images/icon.jpeg',)),

              SizedBox(
                  height: h*.3,
                  width: double.infinity,
                  child:Text("The jobs part is intended to get you a job or offer a job. It is divided into two parts, a part for a person who is looking for a job, and a part for a person who offers a job.",
                    style: TextStyle(color:Colors.black,fontSize: 13.0,fontWeight:FontWeight.bold, ),

                  )

              ),
              SizedBox(
                height: h*.05,
                width:double.infinity,
                child:   RaisedButton(
                  color: Colors.green,
                  onPressed: (){
                    Get.toNamed(Routes.find_job);
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Text('البحث عن وظيفه',
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
                    Get.toNamed(Routes.job_offer);
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Text(' عرض وظيفه',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: w*.05,
                    ),


                  ),
                ),
              ),

            ],

          ),
        ),
      ),
    );


  }
}
