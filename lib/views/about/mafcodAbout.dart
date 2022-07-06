import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/routes/app_routes.dart';
import 'package:get/get.dart';
class mafcodAbout extends StatefulWidget {
  @override
  State<mafcodAbout> createState() => _mafcodAboutState();
}

class _mafcodAboutState extends State<mafcodAbout> {
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
                  child:Text("The lost part is divided into two parts, the one who lost something, he downloads the thing he lost, and the second part, who finds something, downloads the thing he found and shows all the things that were lost from people",
                    style: TextStyle(color:Colors.black,fontSize: 13.0,fontWeight:FontWeight.bold, ),

                  )

              ),
              SizedBox(
                height: h*.05,
                width:double.infinity,
                child:   RaisedButton(
                  color: Colors.green,
                  onPressed: (){
                    Get.toNamed(Routes.Loast);
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Text('الابلاغ عن المفقودات',
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
                    Get.toNamed(Routes.mafcod);
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Text('قائمة المفقودات',
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
