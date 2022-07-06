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
class provideJob extends StatefulWidget {
  final String? authToken;
  final int?id;
  const provideJob({Key? key, this.authToken, this.id}) : super(key: key);

  @override
  _provideJobState createState() => _provideJobState();
}

class _provideJobState extends State<provideJob> {
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
      Uri.parse('https://project-graduation.000webhostapp.com/api/needer/get-all-my-applying-for-provide-jobs')  ,
      headers: {
        "authToken":token!,
      },
    );
    var list1=[];
    List l1=jsonDecode(response.body)["data"] ;
    l1.forEach((element) {
      list1.add(element["job"]);
    });

    return list1;
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
              Text('الوظائف التى تقدمت لها',style: TextStyle(
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
                        return snapshot.data!.isEmpty ||snapshot.data==null?Center(child: Text('لا يوجد وظائق تقدمت لها'),):ListView.builder(
                          shrinkWrap: true,
                          reverse: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            return jobList(

                              education :snapshot.data![index]["required_qualification"],
                              skills:snapshot.data![index]["required_skills"],
                              cirtific:snapshot.data![index]["required_certificates"],
                                attach:snapshot.data![index]["attach"],
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

  required String education,attach,
  required String skills,
  required String cirtific,
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
                Text('المؤهل :',style: TextStyle(
                    fontSize: 13,
                    color: Colors.green),),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Text(education,style: TextStyle(
                      fontSize: 20,
                      color: Colors.black
                  ),),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Text('المهارات:',style: TextStyle(
                    fontSize: 13,
                    color: Colors.green),),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Text(skills,style: TextStyle(
                      fontSize: 20,
                      color: Colors.black
                  ),),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Text(' الشهادات المطلوبه :',style: TextStyle(
                    fontSize: 13,
                    color: Colors.green),),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Text(cirtific,style: TextStyle(
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
            )
          ],
        ),
      ),
    ),
  );
}