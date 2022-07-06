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
import 'package:chat_app/views/widgets/custom_text_field.dart';
import 'package:chat_app/views/widgets/top_header.dart';

class changeDeliverProviderP extends StatefulWidget {
  final int?id;
  const changeDeliverProviderP({Key? key, this.id}) : super(key: key);
  @override
  State<changeDeliverProviderP> createState() => _changeDeliverProviderPState();
}
class _changeDeliverProviderPState extends State<changeDeliverProviderP> {
  final _controller = Get.find<ThemeController>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _controllerL = Get.find<LocalizationController>();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final _controllerT = Get.find<ThemeController>();

  final _controller2 = Get.find<LocalizationController>();
  String?from;
  String?to;
  String?first_date;
  TextEditingController from_c =TextEditingController();
  TextEditingController to_c =TextEditingController();
  TextEditingController first_date_c =TextEditingController();
  Map <String,dynamic>? response_data ;
  http.Response? response;

  String user_url='https://project-graduation.000webhostapp.com/api/helper/get-support-thing-to-be-done';

  Future <Map <String,dynamic>?>  JobOfferV ( )async{
    response = await http.post(
      Uri.parse(user_url) ,
      body: <String,String>
      {
        "post_id":'${widget.id!}'
      },
      headers: {
        "authToken": token!,
      },);
    return jsonDecode(response!.body)["data"];
  }
  void DeleteUserW (String id)async
  {
    await http.post(
        Uri.parse('https://project-graduation.000webhostapp.com/api/helper/delete-support-thing-to-be-done'),
        headers: {
          "authToken": token!,
        },
        body: <String,String>
        {
          "post_id":'${widget.id!}',
        }

    );
  }
  void UpdateJobW (Map<String,dynamic>data)async
  {
    await http.post(
        Uri.parse('https://project-graduation.000webhostapp.com/api/helper/update-support-thing-to-be-done'),
        headers: {
          "authToken": token!,
        },
        body: <String,dynamic>
        {
          "from_place":data["from_place"],
          "to_place":data["to_place"],
          "date":data["date"],
          "post_id":'${widget.id!}',
        }

    );
  }
  @override
  void initState() {
    print(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    var f = MediaQuery.of(context).textScaleFactor;
    return Scaffold(
        key: _scaffoldKey,
        drawer: ProfDrawer(),

        body: FutureBuilder(
          future: JobOfferV(),
          builder: (context,AsyncSnapshot <Map <String ,dynamic>? >snapshot) {
            if(!snapshot.hasData) return Center(child: CircularProgressIndicator());
            else{
               from_c.text=snapshot.data!["from_place"];
              to_c.text=snapshot.data!["to_place"];
              first_date_c.text=snapshot.data!["date"];
              return SingleChildScrollView(
                child:Form(
                  key: _formKey,
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
                      SizedBox(
                        height: h * 0.03,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height*0.2,
                        width: MediaQuery.of(context).size.height*0.2,
                        child: CircleAvatar(

                          radius: 20.0,
                          backgroundImage: NetworkImage('https://st2.depositphotos.com/3837271/7341/i/950/depositphotos_73414473-stock-photo-change-text-sign.jpg'),
                        ),
                      ),

                      SizedBox(
                        height: h * 0.01,
                      ),

                      Padding(
                        padding: EdgeInsets.only(left: 20, top: 20, right: 20),
                        child: Card(
                          /* color: _controller.darkTheme
                            ? AppDarkConstant.APP_DARK_COLOR
                            : Colors.white,*/
                          elevation: 10,
                          margin: EdgeInsets.all(0),
                          shadowColor: AppConstants.K_Border_COlor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: Column(
                              children: [
                                CustomTextField(
                                  hint: 'من',
                                  fontSize: 18.0,
                                  controller:from_c ,
                                  onSaved: (s){from=from_c.text;},
                                ),
                                SizedBox(
                                  height: 7,
                                ),
                                CustomTextField(
                                  hint: 'الى',
                                  fontSize: 18.0,
                                  controller:to_c ,
                                  onSaved: (s){to=to_c.text;},

                                ),

                                SizedBox(
                                  height: 7,
                                ),

                                CustomTextField(
                                  hint: ' تاريخ',
                                  fontSize: 18.0,
                                  controller:first_date_c ,
                                  onSaved: (s){first_date=first_date_c.text;},
                                ),


                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20,top: 20,bottom: 20),
                            child: Container(
                              child: CustomButton(
                                text: "حذف",
                                p: EdgeInsets.all(12),
                                onPress: () {

                                  DeleteUserW('${widget.id!}');
                                },
                              ),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(left: 20,top: 20,bottom: 20),
                            child: Container(
                              child: CustomButton(
                                text: "تعديل",
                                p: EdgeInsets.all(12),
                                onPress: () {
                                  if(_formKey.currentState!.validate())
                                  {
                                    _formKey.currentState!.save();
                                    setState(() {
                                      UpdateJobW( {
                                         "from_place":from,
                                         "to_place":to,
                                         "date":first_date ,
                                        "post_id":'${widget.id!}'
                                      });
                                    });}
                                },
                              ),
                            ),
                          ),
                        ],
                      )


                    ],
                  ),
                ),
              );}},
        ));
  }
}
