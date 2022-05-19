import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:laundry_app_ui/ui/home.dart';
import '../../models/LoginModel.dart';
import '../../resources/singletonPattern/loginBloc.dart';
import '../../utils/constants.dart';
import '../../widgets/app_button.dart';
import '../../widgets/card_widget.dart';


class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  LoginModel userModel = userLoginBloc.userLoginModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.primaryColor,
      body: SafeArea(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(


              right: 0.0,
              top: -20.0,
              child: Opacity(
                opacity: 0.3,
                child: Image.asset(
                  "assets/images/washing_machine_illustration.png",
                ),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: kToolbarHeight,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.0,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "Settings",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      !.copyWith(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 50.0,
                    ),
                    Container(
                      width: double.infinity,
                      constraints: BoxConstraints(
                        minHeight: MediaQuery.of(context).size.height - 200.0,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          topRight: Radius.circular(30.0),
                        ),
                        color: Constants.scaffoldBackgroundColor,
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: 24.0,horizontal: 10
                      ),
                      child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                          child: Column(
                            children: <Widget>[
                              SizedBox(height: 50,),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: Card_Widget(
                                    Radius: 5,
                                    color: const Color(0xffF3F6FD),
                                    child: Padding(
                                      padding: const EdgeInsets.all(30),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [

                                          Row(
                                            //mainAxisAlignment: MainAxisAlignment.end,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              SvgPicture.asset('assets/Icon_svg/userId.svg'),
                                              SizedBox(width: MediaQuery.of(context).size.width/7,),
                                               Text(
                                                '${userModel.name}',
                                                style: TextStyle(fontSize: 15.0),
                                                //  textAlign: TextAlign.start,
                                              )
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(5),
                                            child:Divider(color: Colors.black.withOpacity(0.6),),                                        ),
                                          Row(
                                            //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              SvgPicture.asset('assets/Icon_svg/mobile.svg'),
                                              SizedBox(width: MediaQuery.of(context).size.width/7,),
                                                Expanded(
                                                child:  Text(
                                                  '${userModel.number}',
                                                  style: TextStyle(fontSize: 15.0),
                                                  textAlign: TextAlign.start,
                                                ),
                                              )
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(5),
                                            child:Divider(color: Colors.black.withOpacity(0.6),),                                        ),
                                          Row(

                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children:  [
                                              SvgPicture.asset('assets/Icon_svg/marker.svg'),
                                              SizedBox(width: MediaQuery.of(context).size.width/7,),
                                               Expanded(
                                                child:  Text(
                                                  '${userModel.address}',
                                                  style: TextStyle(fontSize: 15.0),
                                                  textAlign: TextAlign.start,
                                                ),
                                              )
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(10),
                                            child:Divider(color: Colors.black.withOpacity(0.6),),                                        ),
                                          Row(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              SvgPicture.asset('assets/Icon_svg/ide.svg'),
                                              SizedBox(width: MediaQuery.of(context).size.width/7,),
                                               Text(
                                                '${userModel.email}',
                                                style: TextStyle(fontSize: 15.0),
                                                textAlign: TextAlign.center,
                                              )
                                            ],
                                          ),



                                          //Row(children: [],)
                                        ],
                                      ),
                                    ),
                                  )),
                              SizedBox(height: 50,),
                              Card_Widget(
                                Radius: 10,
                                child: AppButton(
                                  type: ButtonType.PRIMARY,
                                  text: 'Logout',
                                  onPressed: (){
                                    showDialog(context: context, builder: (context){
                                      return Center(child: SpinKitFoldingCube(color: Constants.primaryColor,),);
                                    });
                                    Timer(Duration(seconds: 2),(){
                                      Get.offAll(()=>Home());
                                    });
                                  },
                                ),
                              )
                            ],
                          ))
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
