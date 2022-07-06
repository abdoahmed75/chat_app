import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chat_app/views/login/login_view.dart';
import 'package:chat_app/views/widgets/prof_drawer.dart';
import 'package:http/http.dart'as http;
import 'package:chat_app/controllers/localization_controller.dart';
import 'package:chat_app/controllers/theme_controller.dart';
import 'package:chat_app/utils/constants.dart';
import 'package:chat_app/views/widgets/top_header.dart';
class liker extends StatefulWidget {
  final String? authToken;
  final int?id;
  const liker({Key? key, this.authToken, this.id}) : super(key: key);

  @override
  _likerState createState() => _likerState();
}

class _likerState extends State<liker> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final _controllerL = Get.find<LocalizationController>();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final _controllerT = Get.find<ThemeController>();
  Stream<List>dataStream()
  {
    return Stream.periodic(Duration(milliseconds: 100)).asyncMap((event){ return fetchLostData();});
  }
  Future<List> fetchLostData() async {
    var response = await http.post(
      Uri.parse('https://project-graduation.000webhostapp.com/api/helper/get-matches-for-found') ,
      headers: {
        "authToken":token!,
      },
      body:
      {
        "post_id":'${widget.id!}'

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
              Text('المفقودات المشابه',style: TextStyle(
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
                height: 12,
              ),

              Padding(
                padding: const EdgeInsets.only(left: 1,right: 1,bottom: 30),
                child: StreamBuilder(
                    stream: dataStream(),
                    builder: (context,AsyncSnapshot<List> snapshot) {
                      if (snapshot.hasData)
                        return snapshot.data!.isEmpty ||snapshot.data==null?Center(child: Text('لا يوجد مفقودات متشابه'),):ListView.builder(
                          shrinkWrap: true,
                          reverse: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            return jobList(

                              type :snapshot.data![index]["type"],
                              date:snapshot.data![index]["expected_lost_date"],
                              place:snapshot.data![index]["expected_lost_place"],
                              dec :snapshot.data![index]["description"],
                              color1:snapshot.data![index]["first_color"],
                              color2:snapshot.data![index]["second_color"],
                              brand:snapshot.data![index]["brand"],
                              catego:snapshot.data![index]["category"],
                              attach: snapshot.data![index]["attach"],

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

  required String type,date,place,dec,color1,color2,brand,catego,attach,
}){
  return   Padding(
    padding: EdgeInsets.only(left: 20, top: 20, right: 20),
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
              children: [
                Text('النوع :',style: TextStyle(
                    fontSize: 13,
                    color: Colors.green),),
                SizedBox(
                  width: 15,
                ),
                Text(type,style: TextStyle(
                    fontSize: 20,
                    color: Colors.black
                ),),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Text('التاريخ:',style: TextStyle(
                    fontSize: 13,
                    color: Colors.green),),
                SizedBox(
                  width: 15,
                ),
                Text(date,style: TextStyle(
                    fontSize: 20,
                    color: Colors.black
                ),),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Text('المكان:',style: TextStyle(
                    fontSize: 13,
                    color: Colors.green),),
                SizedBox(
                  width: 15,
                ),
                Text(place,style: TextStyle(
                    fontSize: 20,
                    color: Colors.black
                ),),
              ],
            ),
            Row(
              children: [
                Text('الوصف:',style: TextStyle(
                    fontSize: 13,
                    color: Colors.green),),
                SizedBox(
                  width: 15,
                ),
                Text(dec,style: TextStyle(
                    fontSize: 20,
                    color: Colors.black
                ),),
              ],
            ),
            Row(
              children: [
                Text('اللون الاول:',style: TextStyle(
                    fontSize: 13,
                    color: Colors.green),),
                SizedBox(
                  width: 15,
                ),
                Text(color1,style: TextStyle(
                    fontSize: 20,
                    color: Colors.black
                ),),
              ],
            ),
            Row(
              children: [
                Text('اللون الثانوى:',style: TextStyle(
                    fontSize: 13,
                    color: Colors.green),),
                SizedBox(
                  width: 15,
                ),
                Text(color2,style: TextStyle(
                    fontSize: 20,
                    color: Colors.black
                ),),
              ],
            ),
            Row(
              children: [
                Text('الماركه:',style: TextStyle(
                    fontSize: 13,
                    color: Colors.green),),
                SizedBox(
                  width: 15,
                ),
                Text(brand,style: TextStyle(
                    fontSize: 20,
                    color: Colors.black
                ),),
              ],
            ),
            Row(
              children: [
                Text('الفئه:',style: TextStyle(
                    fontSize: 13,
                    color: Colors.green),),
                SizedBox(
                  width: 15,
                ),
                Text(catego,style: TextStyle(
                    fontSize: 20,
                    color: Colors.black
                ),),
              ],
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


              ],
            ),

          ],
        ),
      ),
    ),
  );
}