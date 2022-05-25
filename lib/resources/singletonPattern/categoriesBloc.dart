
import '../repository.dart';

class CategoriesBloc{
  final repository = Repository();
  var _categories;
  dynamic get categoriesModel =>_categories;
  getCategories()async{
    dynamic categoriesModel = await repository.getCat();
    _categories = categoriesModel;
  }
  dispose(){
    _categories.close();
  }
}
final categoriesBloc = CategoriesBloc();