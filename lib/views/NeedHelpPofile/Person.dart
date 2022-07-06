import 'dart:convert';
import 'package:chat_app/routes/app_routes.dart';
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
class Person extends StatefulWidget{
  final int?id;
  final String? authToken;
  const Person({Key? key, this.id, this.authToken}) : super(key: key);

  @override
  _PersonState createState() => _PersonState();
}

class _PersonState extends State<Person> {
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
        Uri.parse('https://project-graduation.000webhostapp.com/api/needer/get-applyers-to-need-money-post')  ,
        headers: {
          "authToken":token!,
        },
        body:<String, String>{

          "post_id":'${widget.id!}'
        }
    );
    return jsonDecode(response.body)["data"];
  }
  void AcceptPersonW (String id)async
  {
    await http.post(
        Uri.parse('https://project-graduation.000webhostapp.com/api/needer/accept-applyer-to-need-money-post'),
        headers: {
          "authToken": token!,
        },
        body: <String,String>
        {
          "applyer_request_id":'${widget.id!}',
        }

    );
  }

  @override
  void initState() {
    print('${widget.id!}');
    super.initState();
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
              Text('الاشخاص المتقدمين لتقديم المساعده',style: TextStyle(
                  fontSize: 20,
                  color: Colors.green[400]
              ),),

              SizedBox(
                height: 5,
              ),
              Padding(
                padding: EdgeInsets.only(left: 10, top: 20, right: 10),
                child: Card(
                  /*color: _controllerT.darkTheme
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
                        return snapshot.data!.isEmpty ||snapshot.data==null?Center(child: Text('لا يوجد متقدمين'),):ListView.builder(
                          shrinkWrap: true,
                          reverse: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {

                            return jobList(

                              name :snapshot.data![index]["helper"]["name"],
                              phone:snapshot.data![index]["helper"]["phone"],
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

    required String name,
    required String phone,

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
                  Text('الاسم :',style: TextStyle(
                      fontSize: 13,
                      color: Colors.green),),
                  SizedBox(
                    width: 15,
                  ),
                  Text(name,style: TextStyle(
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
                  Text(' الفون :',style: TextStyle(
                      fontSize: 13,
                      color: Colors.green),),
                  SizedBox(
                    width: 15,
                  ),
                  Text(phone,style: TextStyle(
                      fontSize: 20,
                      color: Colors.black
                  ),),
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
                        text: "قبول ",
                        p: EdgeInsets.all(12),
                        onPress: () {
                          AcceptPersonW('${widget.id!}');
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20,top: 20,bottom: 20),
                    child: Container(
                      child: CustomButton(
                        text: "رفض ",
                        p: EdgeInsets.all(12),
                        onPress: () {
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