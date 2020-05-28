import 'package:flutterReduxExample/redux/products/products_actions.dart';
import 'package:flutterReduxExample/redux/products/products_state.dart';
import 'package:redux/redux.dart';

final productsReducer = combineReducers<ProductsState>([
  TypedReducer<ProductsState, AddProductsAction>(_addProduct),
]);

ProductsState _addProduct(ProductsState state, AddProductsAction action) {
  final updatedList = state.products;
  updatedList.add(action.product);

  return state.copy(
    products: updatedList,
  );
}
