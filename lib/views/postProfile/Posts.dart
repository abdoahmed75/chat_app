import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chat_app/views/login/login_view.dart';
import 'package:chat_app/views/postProfile/postUpdate.dart';
import 'package:chat_app/views/widgets/prof_drawer.dart';
import 'package:http/http.dart'as http;
import 'package:chat_app/controllers/localization_controller.dart';
import 'package:chat_app/controllers/theme_controller.dart';
import 'package:chat_app/utils/constants.dart';
import 'package:chat_app/views/widgets/custom_button.dart';
import 'package:chat_app/views/widgets/top_header.dart';
class posts extends StatefulWidget {
  final String? authToken;
  const posts({Key? key, this.authToken}) : super(key: key);

  @override
  _postsState createState() => _postsState();
}

class _postsState extends State<posts> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final _controllerL = Get.find<LocalizationController>();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final _controllerT = Get.find<ThemeController>();
  Stream<List>dataStream()
  {
    return Stream.periodic(Duration(milliseconds: 100)).asyncMap((event){ return fetchDeliverData();});
  }
  Future<List> fetchDeliverData() async {
    var response = await http.post(
      Uri.parse('https://project-graduation.000webhostapp.com/api/needer/get-only-my-posts')  ,
      headers: {
        "authToken":token!,
      },
    );
    return jsonDecode(response.body)["data"];
  }
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      drawer: ProfDrawer(),
      body:

      SingleChildScrollView(
        child:Form(
          key:_formKey,
          child: Column(
            children: [
              TopHeaderWithCart(
                w: w,
                h: h,
                isDark: _controllerT.darkTheme,
                lang: _controllerL.lang,
                onClick: () {
                  _scaffoldKey.currentState?.openDrawer();
                },
              ),
              Text('الطلبات التى تم طلبها',style: TextStyle(
                  fontSize: 20,
                  color: Colors.green[400]
              ),),

              SizedBox(
                height: 5,
              ),
              Padding(
                padding: EdgeInsets.only(left: 10, top: 20, right: 10),
                child: Card(
                  /* color: _controllerT.darkTheme
                      ? AppDarkConstant.APP_DARK_COLOR
                      : Colors.white,*/
                  elevation: 10,
                  margin: EdgeInsets.all(0),
                  shadowColor: AppConstants.K_Border_COlor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),

                ),
              ),
              SizedBox(
                height: 25,
              ),

              SizedBox(
                height: 25,
              ),


              Padding(
                padding: const EdgeInsets.only(left: 1,right: 1,bottom: 30),
                child: StreamBuilder(
                    stream: dataStream(),
                    builder: (context,AsyncSnapshot<List> snapshot) {
                      if (snapshot.hasData)
                        return snapshot.data!.isEmpty ||snapshot.data==null?Center(child: Text('لا يوجدطلبات حاليا'),):ListView.builder(
                          shrinkWrap: true,
                          reverse: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            return jobList(
                             // name:snapshot.data![index]["type_of_service"],
                              date:snapshot.data![index]["created_at"],
                              post:snapshot.data![index]["content"],
                              attach: snapshot.data![index]["attach"],
                              post_type:snapshot.data![index]["post_type"],
                              id: snapshot.data![index]["id"],
                            );

                          },
                          itemCount: snapshot.data!.length,
                        );
                      else return Center(child: CircularProgressIndicator(),);
                    }
                ),
              ),
            ],

          ),
        ),
      ),
    );

  }
}
Widget jobList({

  required String date,post,attach,post_type,
  required int id,

}){
  return   Padding(
    padding: EdgeInsets.only(left: 20, top: 20, right: 5),
    child: Card(
      color: Colors.white,
      elevation: 10,
      margin: EdgeInsets.all(0),
      shadowColor: AppConstants.K_Border_COlor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Text(post_type,style: TextStyle(
                      fontSize: 12,
                      color: Colors.black54
                  ),),
                ),
                Expanded(
                  child: SizedBox(
                    width: 45,
                  ),
                ),
                Expanded(
                  child: Text(date,style: TextStyle(
                    fontSize: 10,
                    color: Colors.black54,
                  ),),
                ),

              ],
            ),

            Divider(),

            Padding(
              padding: const EdgeInsets.only(bottom:60),
              child: Row(
                children: [

                  Expanded(
                    child: Text(post,style: TextStyle(
                        fontSize: 15,
                        color: Colors.black
                    ),),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Divider(),
            Divider(),
            Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      width: double.infinity,
                      child:attach!=''?Image.network(attach):Image.asset('assets/images/icon.jpeg'),
                    ),
                  ),
                ]
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10,bottom: 10),
                  child: Container(
                    //margin: EdgeInsets.symmetric(horizontal: w * 0.2),
                    child: CustomButton(
                      text: "تعديل",
                      p: EdgeInsets.all(12),
                      onPress: () {
                        Get.to(()=>postUpdate(id:id));
                      },
                    ),
                  ),
                ),

              ],
            )

          ],
        ),
      ),
    ),
  );

}