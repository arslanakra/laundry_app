
import '../repository.dart';

class GetOrderBloc{
  final repository = Repository();
  var _getOrder;
  dynamic get getOrderModel =>_getOrder;
  getOrder(int id)async{
    dynamic getOrderModel = await repository.getOrder(id);
    _getOrder = getOrderModel;
  }
  dispose(){
    _getOrder.close();
  }
}
final getOrderBloc = GetOrderBloc();