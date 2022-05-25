import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laundry_app_ui/controller/OrderController.dart';
import 'package:laundry_app_ui/models/CategoriesModel.dart';
import 'package:laundry_app_ui/resources/singletonPattern/categoriesBloc.dart';
import 'package:laundry_app_ui/widgets/card_widget.dart';

import '../../models/LoginModel.dart';
import '../../resources/singletonPattern/loginBloc.dart';
import '../../utils/constants.dart';
import '../../widgets/app_button.dart';

class NewOrderScreen extends StatefulWidget {
  const NewOrderScreen({Key? key}) : super(key: key);

  @override
  State<NewOrderScreen> createState() => _NewOrderScreenState();
}

class _NewOrderScreenState extends State<NewOrderScreen> {
  late OrderController orderController;
  LoginModel userModel = userLoginBloc.userLoginModel;
  CategoriesModel? categoriesModel;
  bool isLoading = true;
  getData() async{
    isLoading = true;
    await categoriesBloc.getCategories();
    setState(() {
      categoriesModel = categoriesBloc.categoriesModel;
      isLoading = false;
    });
  }

  @override
  void initState() {
    try{
      orderController = Get.find();
    }catch(E){
      orderController = Get.put(OrderController());
    }
    orderController.myDispose();
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(
      id:'NewOrderScreen',
      builder:(_)=> Scaffold(
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
                                    text: "Place Order",
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
                          vertical: 24.0,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            isLoading ? SpinKitFoldingCube(color: Constants.primaryColor,):
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                      Text('Items',style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.bold),),
                                      SizedBox(width: 20,),
                                      Text('Dry Clean\nPrice',style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.bold),textAlign: TextAlign.center),
                                      SizedBox(width: 20,),
                                      Text('Add\nQuantity',style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.bold),textAlign: TextAlign.center),
                                    ],),
                                  ),
                                  Divider(color: Constants.primaryColor,thickness: 2),
                                  ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: categoriesModel!.results!.length,
                                    itemBuilder: (ctx,index){
                                      orderController.controllers.add(TextEditingController());
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(categoriesModel!.results![index].catName.toString(),style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.bold),),
                                            SizedBox(width: 20,),
                                            Text(categoriesModel!.results![index].price.toString(),style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.w400),),
                                            SizedBox(width: 40,),
                                            Container(
                                              padding: EdgeInsets.only(bottom: 5,left: 5),
                                              width:MediaQuery.of(context).size.width * 0.09,
                                              height:MediaQuery.of(context).size.height * 0.05,
                                              decoration: BoxDecoration(
                                                border: Border.all(color: Constants.primaryColor,width: 2),
                                              ),
                                              child: Center(
                                                child: TextField(
                                                  onEditingComplete: (){
                                                    if(orderController.controllers[index].text.isNotEmpty){
                                                      FocusManager.instance.primaryFocus?.unfocus();
                                                      orderController.setValuesCalculate(int.parse(categoriesModel!.results![index].price.toString())
                                                        ,int.parse(orderController.controllers[index].text),
                                                        categoriesModel!.results![index].catName.toString()
                                                      );
                                                    }else{
                                                      orderController.setValuesCalculate(int.parse('0'),int.parse('0'),'');
                                                    }

                                                  },
                                                  onChanged: (v){

                                                  // if(orderController.controllers[index].text.isEmpty){
                                                  //       orderController.show(int.parse('0'),int.parse('0'),'');
                                                  //       // orderController.total = 0;
                                                  //       orderController.data.removeAt(index);
                                                  // }
                                                  },

                                                  controller: orderController.controllers[index],
                                                  cursorColor: Colors.blue,
                                                  keyboardType: TextInputType.number,
                                                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r"[0-9]"))],
                                                  decoration: InputDecoration(
                                                    contentPadding: EdgeInsets.symmetric(vertical: -5),
                                                    border: InputBorder.none,
                                                    focusedBorder: InputBorder.none,
                                                    enabledBorder: InputBorder.none,
                                                    errorBorder: InputBorder.none,
                                                    disabledBorder: InputBorder.none,
                                                    hintStyle: GoogleFonts.poppins(
                                                      textStyle:
                                                      TextStyle(fontSize: 20),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      );
                                    }

                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Divider(color: Constants.primaryColor,thickness: 2),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Spacer(),
                                        Text('Total Price',style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.bold),),
                                        SizedBox(width: 40,),
                                        Text(orderController.total.toString(),style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.normal),),
                                      ],
                                    ),
                                  ),
                                  Card_Widget(
                                    Radius: 10,
                                    child: AppButton(
                                      type: ButtonType.PRIMARY,
                                      text: 'Place Order',
                                      onPressed: ()async{
                                        if(orderController.total == 0){
                                          Get.snackbar('Warning', 'Add Some Quantity',backgroundColor: Colors.red,colorText: Colors.white);
                                        }else{
                                          showDialog(context: context, builder: (context){
                                            return Center(child: SpinKitFoldingCube(color: Constants.primaryColor,),);
                                          });
                                         await orderController.getLocation();
                                          orderController.orderBody['total'] = orderController.total;
                                          orderController.orderBody['user_id'] = userModel.id;
                                          orderController.orderBody['lat'] = orderController.currentPosition!.latitude;
                                          orderController.orderBody['lng'] = orderController.currentPosition!.longitude;
                                          orderController.orderBody['status'] = '0';
                                          orderController.orderBody['order_items'] = orderController.categoryList;
                                          print(jsonEncode(orderController.orderBody));
                                          await orderController.sendOrder(jsonEncode(orderController.orderBody));
                                          Navigator.pop(context);
                                        }


                                      },
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
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
