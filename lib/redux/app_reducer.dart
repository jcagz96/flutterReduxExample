import 'package:flutterReduxExample/redux/app_actions.dart';
import 'package:flutterReduxExample/redux/app_state.dart';
import 'package:flutterReduxExample/redux/products/products_actions.dart';
import 'package:flutterReduxExample/redux/products/products_reducer.dart';
import 'package:redux/redux.dart';

final appReducer = combineReducers<AppState>([
  TypedReducer<AppState, IncrementCounter>(_incrementReducer),
  TypedReducer<AppState, DecrementCounter>(_decrementReducer),
  TypedReducer<AppState, ProductsAction>(_productReducer),
]);

AppState _incrementReducer(AppState state, IncrementCounter action) {
  return state.copyWith(
    counter: state.counter + action.value,
  );
}

AppState _decrementReducer(AppState state, DecrementCounter action) {
  return state.copyWith(
    counter: state.counter - 1,
  );
}

AppState _productReducer(AppState state, ProductsAction action) {
  return state.copyWith(
    productsState: productsReducer(state.productsState, action),
  );
}
