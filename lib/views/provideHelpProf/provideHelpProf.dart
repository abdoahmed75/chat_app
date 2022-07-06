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
import 'package:chat_app/views/widgets/custom_button.dart';
import 'package:chat_app/views/widgets/top_header.dart';
class provideHelpProf extends StatefulWidget {
  final String? authToken;
  const provideHelpProf({Key? key, this.authToken}) : super(key: key);

  @override
  _provideHelpProfState createState() => _provideHelpProfState();
}

class _provideHelpProfState extends State<provideHelpProf> {

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
      Uri.parse('https://project-graduation.000webhostapp.com/api/helper/get-all-my-provide-financial-helps')  ,
      headers: {
        "authToken":token!,
      },
    );
      var list1=[];
      List l1=jsonDecode(response.body)["data"] ;
    l1.forEach((element) {
      list1.add(element["post"]);
    });

    return list1;
  }
  void DeleteHelp (String id)async
  {
    await http.post(
        Uri.parse('https://project-graduation.000webhostapp.com/api/helper/delete-my-provide-financial-help'),
        headers: {
          "authToken": token!,
        },
        body:<String,String>
        {
          "apply_id":id,
        }

    );
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
              Text('المساعدات التى تم طلبها',style: TextStyle(
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
                        return snapshot.data!.isEmpty ||snapshot.data==null?Center(child: Text('لا يوجد طالبات حاليا'),):ListView.builder(
                          shrinkWrap: true,
                          reverse: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            return jobList(

                              type:snapshot.data![index]["type_of_help"],
                              address :snapshot.data![index]["specific_address"],
                              value:snapshot.data![index]["value"],
                              person:snapshot.data![index]["target_help"],
                              pay:snapshot.data![index]["provide_help_way"],
                              name:snapshot.data![index]["another_user_name"],
                              attach: snapshot.data![index]["attach"],
                              id:snapshot.data![index]["id"],
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

Widget jobList({
  required String type,address,person,pay,name,attach,
  required int id,value,
}){
  return   Padding(
    padding: EdgeInsets.only(left: 20, top: 20, right: 10),
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
                Text('نوع المساعده :',style: TextStyle(
                    fontSize: 12,
                    color: Colors.green),),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Text(type,style: TextStyle(
                      fontSize: 22,
                      color: Colors.black
                  ),),
                ),
              ],
            ),
            Divider(),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Text('العنوان:',style: TextStyle(
                    fontSize: 12,
                    color: Colors.green),),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Text(address,style: TextStyle(
                      fontSize: 22,
                      color: Colors.black
                  ),),
                ),
              ],
            ),
            Divider(),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Text(' القيمه :',style: TextStyle(
                    fontSize: 12,
                    color: Colors.green),),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Text(value.toString(),style: TextStyle(
                      fontSize: 22,
                      color: Colors.black
                  ),),
                ),
              ],
            ),
            Divider(),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Text(' لمن المساعده :',style: TextStyle(
                    fontSize: 12,
                    color: Colors.green),),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Text(person,style: TextStyle(
                      fontSize: 22,
                      color: Colors.black
                  ),),
                ),
              ],
            ),
            Divider(),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Text(' طريقة الدفع :',style: TextStyle(
                    fontSize: 12,
                    color: Colors.green),),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Text(pay,style: TextStyle(
                      fontSize: 22,
                      color: Colors.black
                  ),),
                ),
              ],
            ),
            Divider(),
            SizedBox(
              height: 15,
            ),

            Row(
              children: [
                Text(' الاسم :',style: TextStyle(
                    fontSize: 12,
                    color: Colors.green),),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Text(name,style: TextStyle(
                      fontSize: 22,
                      color: Colors.black
                  ),),
                ),
              ],
            ),
            Divider(),
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
                      text: "help",
                      p: EdgeInsets.all(12),
                      onPress: () {
                        DeleteHelp(id.toString());
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
}}