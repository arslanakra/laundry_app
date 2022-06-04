
import '../repository.dart';

class CancelBloc{
  final repository = Repository();
  var _cancelOrder;
  dynamic get cancelOrderModel =>_cancelOrder;
  cancelOrder(int id)async{
    dynamic cancelOrderModel = await repository.cancelOrder(id);
    _cancelOrder = cancelOrderModel;
  }
  dispose(){
    _cancelOrder.close();
  }
}
final cancelOrderBloc = CancelBloc();