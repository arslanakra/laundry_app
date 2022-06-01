import 'package:flutter/material.dart';
import 'package:flutter_icons_null_safety/flutter_icons_null_safety.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:laundry_app_ui/api/auth_controller.dart';
import 'package:laundry_app_ui/ui/navigationScreen.dart';
import 'package:laundry_app_ui/utils/constants.dart';
import 'package:laundry_app_ui/widgets/app_button.dart';
import 'package:laundry_app_ui/widgets/input_widget.dart';

import '../models/LoginModel.dart';
import '../resources/singletonPattern/GetOrderBloc.dart';
import '../resources/singletonPattern/loginBloc.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
   late AuthController authController;
   @override
   void initState() {
     try{
       authController = Get.find();
     }catch(E){
       authController = Get.put(AuthController());
     }
     super.initState();

   }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.primaryColor,
      body: SafeArea(
        bottom: false,
        child: Container(
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
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 15.0,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Icon(
                                FlutterIcons.keyboard_backspace_mdi,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Text(
                              "Log in to your account",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  !.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 40.0,
                      ),
                      Flexible(
                        child: Container(
                          width: double.infinity,
                          constraints: BoxConstraints(
                            minHeight:
                                MediaQuery.of(context).size.height * 0.8,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30.0),
                              topRight: Radius.circular(30.0),
                            ),
                            color: Colors.white,
                          ),
                          padding: EdgeInsets.all(24.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              // Lets make a generic input widget
                              InputWidget(
                                controller: authController.emailController,
                                topLabel: "Email",
                                hintText: "Enter your email address",
                              ),
                              SizedBox(
                                height: 25.0,
                              ),
                              InputWidget(
                               controller: authController.passController,
                                topLabel: "Password",
                                obscureText: true,
                                hintText: "Enter your password",
                              ),
                              SizedBox(
                                height: 15.0,
                              ),
                              // GestureDetector(
                              //   onTap: () {},
                              //   child: Text(
                              //     "Forgot Password?",
                              //     textAlign: TextAlign.right,
                              //     style: TextStyle(
                              //       color: Constants.primaryColor,
                              //       fontWeight: FontWeight.w600,
                              //     ),
                              //   ),
                              // ),
                              SizedBox(
                                height: 20.0,
                              ),
                              AppButton(
                                type: ButtonType.PRIMARY,
                                text: "Log In",
                                onPressed: ()async {
                                  if(authController.emailController.text.isNotEmpty && authController.passController.text.isNotEmpty)
                                  {
                                    showDialog(
                                        barrierDismissible: false,
                                        context: context,
                                        builder: (dialogContext) {
                                          return Center(
                                              child: SpinKitFoldingCube(
                                            color: Constants.primaryColor,
                                            size: 50,
                                          ));
                                        });

                                    await userLoginBloc.getUserLogin(
                                        authController.emailController.text,
                                        authController.passController.text);
                                    LoginModel loginModel = userLoginBloc.userLoginModel;
                                    await getOrderBloc.getOrder(loginModel.id!);
                                    Navigator.of(context).pop();
                                    if (loginModel.user!.contains('user')) {
                                      Get.snackbar('Success', 'User Logged In Successfully', snackPosition: SnackPosition.BOTTOM);
                                      Get.offAll(() => NavigationScreen(),
                                          transition: Transition.leftToRight);
                                    }
                                  }
                                  else{
                                    Get.snackbar('Error', 'Fields must not be empty', snackPosition: SnackPosition.BOTTOM,backgroundColor:Colors.red,colorText: Colors.white);
                                  }
                                },
                              )
                            ],
                          ),
                        ),
                      )
                    ],
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
