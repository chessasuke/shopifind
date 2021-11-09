import 'mock_shopping_list_model.dart';

class MockUserModel {
  MockUserModel(
      {required this.address, required this.name, required this.shoppingLists});

  final String name;
  final String address;
  final List<MockShoppingList> shoppingLists;
  // final List<UserModel> followers;
  // final List<UserModel> following;

  factory MockUserModel.initial() => MockUserModel(name : 'Jhon Doe', address: '555 street PS', shoppingLists: []);

  MockUserModel copyWith({
    String? name,
    String? address,
    List<MockShoppingList>? shoppingLists,
  }) {
    return MockUserModel(
      name: name ?? this.name,
      address: address ?? this.address,
      shoppingLists: this.shoppingLists,
    );
  }
}
