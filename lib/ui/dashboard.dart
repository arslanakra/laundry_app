import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:laundry_app_ui/api/auth_controller.dart';
import 'package:laundry_app_ui/models/LoginModel.dart';
import 'package:laundry_app_ui/resources/singletonPattern/GetOrderBloc.dart';
import 'package:laundry_app_ui/ui/single_order.dart';
import 'package:laundry_app_ui/utils/constants.dart';
import 'package:laundry_app_ui/widgets/location_slider.dart';

import '../models/GetOrderModel.dart';
import '../resources/singletonPattern/loginBloc.dart';
import '../widgets/order_card.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  int activeIndex = 0;
  LoginModel loginModel = userLoginBloc.userLoginModel;
  GetOrderModel orderModel = getOrderBloc.getOrderModel;
  late AuthController authController;
  @override
  void initState() {
    try{
      authController = Get.find();
    }catch(E){
      authController = Get.put(AuthController());
    }
    authController.getLocation();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
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

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "Welcome,\n",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6
                                            !.copyWith(
                                              color: Colors.white,
                                            ),
                                      ),
                                      TextSpan(
                                        text: "${loginModel.name}!",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6
                                            !.copyWith(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600,
                                            ),
                                      )
                                    ],
                                  ),
                                ),

                              ],
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
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 24.0,
                              ),
                              child: Text(
                                "Your Location",
                                style: TextStyle(
                                  color: Color.fromRGBO(19, 22, 33, 1),
                                  fontSize: 18.0,
                                ),
                              ),
                            ),
                            SizedBox(height: 7.0),
                            Container(
                              padding: EdgeInsets.only(left: 25),
                              height: 100.0,
                              child: Container(
                                width: 200.0,
                                decoration: BoxDecoration(
                                  color: Constants.primaryColor,
                                  borderRadius: BorderRadius.circular(8.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color.fromRGBO(169, 176, 185, 0.42),
                                      spreadRadius: 0,
                                      blurRadius: 8.0,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                                padding: EdgeInsets.symmetric(
                                  vertical: 16.0,
                                  horizontal: 12.0,
                                ),
                                child: Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    Positioned(
                                      right: -16.0,
                                      top: 0.05,
                                      bottom: 0.05,

                                      child: Opacity(
                                        opacity: 0.69,
                                        child: Image.asset(
                                          'assets/images/house2.png',
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Text(
                                        "${authController.address}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          height: 1.5,
                                          fontSize: 14.0,
                                          color: Colors.white
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),

                           orderModel.data!.length == 0 ? Padding(
                             padding: const EdgeInsets.only(top: 18.0),
                             child: Center(child: Text('No Order Placed Yet!',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),)),
                           ): ListView.separated(
                              shrinkWrap: true,
                              padding: EdgeInsets.symmetric(
                                horizontal: 16.0,
                                vertical: 10.0,
                              ),
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) {
                                // Lets pass the order to a new widget and render it there
                                return InkWell(
                                  onTap: (){
                                    Get.to(SingleOrder(num: orderModel.data![index].id.toString(),items: orderModel.data![index].orderItems,total: orderModel.data![index].total.toString(),));
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8.0),
                                      border: Border.all(
                                        color: Color.fromRGBO(220, 233, 245, 1),
                                      ),
                                    ),
                                    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 16.0),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        getOrderIconWidget(orderModel.data![index].status!),
                                        SizedBox(
                                          width: 25.0,
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                orderModel.data![index].status == 0 ? 'Order Placed' : 'Delivering',
                                                style: TextStyle(
                                                  color: Color.fromRGBO(19, 22, 33, 1),
                                                  fontSize: 16.0,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5.0,
                                              ),
                                              textRow("Order No", '${orderModel.data![index].id}'),
                                              SizedBox(
                                                height: 5.0,
                                              ),
                                              textRow("Total Price", 'Rs. ${orderModel.data![index].total}'),
                                              SizedBox(
                                                height: 10.0,
                                              ),
                                              textRow("Placed On", orderModel.data![index].createdAt.toString().substring(0,orderModel.data![index].createdAt.toString().indexOf('T')).toString()),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                );
                              },
                              separatorBuilder: (BuildContext context, int index) {
                                return SizedBox(
                                  height: 15.0,
                                );
                              },
                              itemCount: orderModel.data!.length,
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
