import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chat_app/routes/app_routes.dart';
import 'package:chat_app/views/DeliverPerson/DeliverPerson.dart';
import 'package:chat_app/views/Deliver_P/acceptDeliver.dart';
import 'package:chat_app/views/Deliver_P/likerDeliver.dart';
import 'package:chat_app/views/login/login_view.dart';
import 'package:chat_app/views/widgets/prof_drawer.dart';
import 'package:http/http.dart'as http;
import 'package:chat_app/controllers/localization_controller.dart';
import 'package:chat_app/controllers/theme_controller.dart';
import 'package:chat_app/utils/constants.dart';
import 'package:chat_app/views/widgets/custom_button.dart';
import 'package:chat_app/views/widgets/top_header.dart';
import '../changeDeliverP/changeDeliverP.dart';
class Deliver_P extends StatefulWidget {
  final String? authToken;
  const Deliver_P({Key? key, this.authToken}) : super(key: key);

  @override
  _Deliver_PState createState() => _Deliver_PState();
}

class _Deliver_PState extends State<Deliver_P> {
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
      Uri.parse('https://project-graduation.000webhostapp.com/api/needer/get-all-my-things-to-be-done')  ,
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
                              service:snapshot.data![index]["type_of_service"],
                              first_p:snapshot.data![index]["from_place"],
                              end_p:snapshot.data![index]["to_place"],
                              cost:snapshot.data![index]["opposite"],
                              first_date:snapshot.data![index]["from_date"],
                              end_date:snapshot.data![index]["to_date"],
                              attach:snapshot.data![index]["attach"],
                              //note:snapshot.data![index]["note"],
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
  required String service,
  required String first_p,attach,
  required String end_p,
  required int cost,
  required String first_date,
  required String end_date,
  required int id,
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
                Text('نوع الخدمه :',style: TextStyle(
                    fontSize: 13,
                    color: Colors.green),),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Text(service,style: TextStyle(
                      fontSize: 20,
                      color: Colors.black
                  ),),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Divider(),
            Row(
              children: [
                Text('نقطة البدايه:',style: TextStyle(
                    fontSize: 13,
                    color: Colors.green),),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Text(first_p,style: TextStyle(
                      fontSize: 20,
                      color: Colors.black
                  ),),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Divider(),
            Row(
              children: [
                Text('نقطة النهايه:',style: TextStyle(
                    fontSize: 13,
                    color: Colors.green),),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Text(end_p,style: TextStyle(
                      fontSize: 20,
                      color: Colors.black
                  ),),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Divider(),
            Row(
              children: [
                Text('المقابل:',style: TextStyle(
                    fontSize: 13,
                    color: Colors.green),),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Text(cost.toString(),style: TextStyle(
                      fontSize: 20,
                      color: Colors.black
                  ),),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Divider(),
            Row(
              children: [
                Text('التاريخ:',style: TextStyle(
                    fontSize: 13,
                    color: Colors.green),),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Text(first_date,style: TextStyle(
                      fontSize: 20,
                      color: Colors.black
                  ),),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Divider(),
            Row(
              children: [
                Text('اقصى تاريخ:',style: TextStyle(
                    fontSize: 13,
                    color: Colors.green),),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Text(end_date,style: TextStyle(
                      fontSize: 20,
                      color: Colors.black
                  ),),
                ),
              ],
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
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20,top: 20,bottom: 20),
                  child: Container(
                    child: CustomButton(
                      text: "تعديل ",
                      p: EdgeInsets.all(12),
                      onPress: () {
                        Get.to(()=>changeDeliverP(id:id));
                      },
                    ),
                  ),
                ),


                Padding(
                  padding: const EdgeInsets.only(left: 20,top: 20,bottom: 20),
                  child: Container(
                    child: CustomButton(
                      text: "المتقدمين ",
                      p: EdgeInsets.all(12),
                      onPress: () {
                        // Get.toNamed(Routes.jobofferperson);
                        Get.to(()=>DeliverPerson(id:id));
                      },
                    ),
                  ),
                ),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20,top: 20,bottom: 20),
                  child: Container(
                    child: CustomButton(
                      text: "المقبولين ",
                      p: EdgeInsets.all(12),
                      onPress: () {
                        Get.to(()=>acceptDeliver(id:id));
                      },
                    ),
                  ),
                ),


                Padding(
                  padding: const EdgeInsets.only(left: 20,top: 20,bottom: 20),
                  child: Container(
                    child: CustomButton(
                      text: "المتشابه ",
                      p: EdgeInsets.all(12),
                      onPress: () {
                        // Get.toNamed(Routes.jobofferperson);
                        Get.to(()=>likerDeliver(id:id));
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