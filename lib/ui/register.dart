import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons_null_safety/flutter_icons_null_safety.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:laundry_app_ui/ui/login.dart';
import '../api/auth_controller.dart';
import '../utils/constants.dart';
import '../widgets/app_button.dart';
import '../widgets/input_widget.dart';
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
                              "Sign up for new account",
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
                      Container(
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
                              topLabel: "Name",
                              controller: authController.nameController,
                              hintText: "Enter your name",
                            ),
                            SizedBox(
                              height: 25.0,
                            ),
                            InputWidget(
                              topLabel: "Address",
                              controller: authController.addressController,
                              hintText: "Enter your address",
                            ),
                            SizedBox(
                              height: 25.0,
                            ),
                            InputWidget(
                              topLabel: "Number",
                              format: [FilteringTextInputFormatter.allow(RegExp('^[0-9]+|r'))],
                              type: TextInputType.number,
                              controller: authController.numberController,
                              hintText: "Enter your number",
                            ),
                            SizedBox(
                              height: 25.0,
                            ),
                            InputWidget(
                              topLabel: "Email",
                              controller: authController.regEmailController,
                              hintText: "Enter your email address",
                            ),
                            SizedBox(
                              height: 25.0,
                            ),
                            InputWidget(
                              topLabel: "Password",
                              controller: authController.regPassController,
                              obscureText: true,
                              hintText: "Enter your password",
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            InputWidget(
                              topLabel: "Confirm Password",
                              controller: authController.regConfirmPassController,
                              obscureText: true,
                                hintText: "Confirm your password",
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            AppButton(
                              type: ButtonType.PRIMARY,
                              text: "Register",
                              onPressed: () async {
                                if(authController.regPassController.text.isNotEmpty&&authController.regEmailController.text.isNotEmpty
                                    &&authController.nameController.text.isNotEmpty
                                    &&authController.addressController.text.isNotEmpty
                                    &&authController.numberController.text.isNotEmpty){
                                  if(authController.regPassController.text == authController.regConfirmPassController.text){
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
                                    await authController.signupRequest(authController.nameController.text, authController.regEmailController.text, authController.regPassController.text,
                                        authController.numberController.text, authController.addressController.text);
                                    Navigator.of(context).pop();
                                    if(authController.isRegistered == 'Success'){
                                      Get.offAll(()=>Login(),transition: Transition.leftToRight);
                                      Get.snackbar('Welcome', 'Login to access your account', snackPosition: SnackPosition.BOTTOM);
                                    }
                                  }else{
                                    Get.snackbar('Error', 'Password not matched', snackPosition: SnackPosition.BOTTOM,backgroundColor:Colors.red,colorText: Colors.white);
                                  }
                                }else{
                                  Get.snackbar('Error', 'Fields must not be empty', snackPosition: SnackPosition.BOTTOM,backgroundColor:Colors.red,colorText: Colors.white);
                                }

                              },
                            )
                          ],
                        ),
                      )
                    ],
                  ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

