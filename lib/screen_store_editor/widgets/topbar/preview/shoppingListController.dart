// ignore_for_file: file_names

// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:shopifind/preview/mock_shopping_list_model.dart';
// import 'package:shopifind/preview/mock_user_model.dart';

// final mockedUserProvider = StateProvider((ref) => MockUserModel.initial());

// final shoppingListControllerProvider = StateNotifierProvider((ref) {
//   final currentUser = ref.watch(mockedUserProvider).state;
//   return ShoppingListController(currentUser.shoppingLists);
// });

// class ShoppingListController extends StateNotifier<List<MockShoppingList>> {
//   ShoppingListController([List<MockShoppingList>? products])
//       : super(products ?? []);

//   void add(MockShoppingList newShoppingList) {
//     state = [
//       ...state,
//       newShoppingList,
//     ];
//   }

//   void addList(MockShoppingList newList) {
//     state = [
//       ...state,
//       newList,
//     ];
//   }

//   void editList(String name, MockShoppingList newList) {
//     state = state.where((element) => element.name != name).toList();
//     state = [
//       ...state,
//       newList,
//     ];
//   }

//   void removeList(String name) {
//     state = state.where((list) => list.name != name).toList();
//   }

//   void clear() {
//     state = [];
//   }
// }
