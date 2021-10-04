import 'package:shopifind/model/canv_object_model.dart';
import 'package:shopifind/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// provides id of selected canvas object
final selectedObjectIdProvider = StateProvider((ref) => '');

/// provides canvas object selected
final selectedObjectProvider = StateProvider((ref) {
  final String selectedObjId = ref.watch(selectedObjectIdProvider).state;
  if (selectedObjId != '') {
    CanvObjectModel? object =
        ref.watch(objsControllerProvider.notifier).selectObj(selectedObjId);
    print('object : ${object!.id} selected');
    return object;
  } else {
    print('no object selected');
    return null;
  }
});

// /// provides all canvas objects
final objRepositoryProvider = StateProvider((ref) {
  final allObjs = ref.watch(objsControllerProvider);
  return allObjs;
});

/// manage/control the objects repository
final objsControllerProvider = StateNotifierProvider((ref) {
  // final currentStore = ref.watch(selectedStoreProvider).state;
  // print('currentStore: $currentStore');
  // print('currentStore objects type: ${currentStore.objects.runtimeType}');

  // if (currentStore.objects.isNotEmpty) {
  //   print('objs NOT empty');
  //   return CanvObjsNotifier(currentStore.objects);
  // } else {
  //       print('objs empty, craeting new CanvObjsNotifier');
  //   return CanvObjsNotifier();
  // }
  return CanvObjsNotifier();
});

class CanvObjsNotifier extends StateNotifier {
  CanvObjsNotifier([List<CanvObjectModel>? canvObj])
      : super(canvObj ?? <CanvObjectModel>[]);

  /// Select an object, which changes the stack. After selection the object is on the top
  /// (stack first child painted is on the bottom)
  CanvObjectModel? selectObj(String id) {
    List<CanvObjectModel> newState = [];
    CanvObjectModel? selectedObject;

    for (final CanvObjectModel obj in state) {
      if (obj.id == id) {
        selectedObject = obj.copyWith(isSelected: true);
        newState.add(selectedObject);
      } else if (obj.isSelected) {
        newState.add(obj.copyWith(isSelected: false));
      } else {
        newState.add(obj);
      }
    }

    state = newState;
    return selectedObject;
    //// *** From Remi's example ***
    // state = [
    //   for (final CanvObjectModel obj in state)
    //     if (obj.id == id)
    //       obj.copyWith(isSelected: true)
    //     else if (obj.isSelected)
    //       obj.copyWith(isSelected: false)
    //     else
    //       obj,
    // ];
  }

  void deselectObj() {
    state = [
      for (final CanvObjectModel obj in state)
        if (obj.isSelected) obj.copyWith(isSelected: false) else obj,
    ];
  }

  void addObject(CanvObjectModel newObj) {
    print('newObj to add: $newObj');

    /// if new object is store dimension put it at the
    /// bottom of the stack so it doesnt interfiere with
    /// the rest of the objects
    if (newObj.objType == ObjectType.store) {
      state = [newObj, ...state];
    } else {
      state = [...state, newObj];
    }
    print('state length: ${state.length}');
    print('object added');
  }

  /// remove object from canvas
  void removeObject(String id) {
    state = state.where((CanvObjectModel obj) => obj.id != id).toList();
  }

  /// toggle object lock in canvas
  /// if open object can be translated
  void toggleLock(String id) {
    final CanvObjectModel tempObj =
        state.firstWhere((CanvObjectModel element) => element.id == id);
    final CanvObjectModel updatedObj =
        tempObj.copyWith(isLocked: !tempObj.isLocked);
    state = [
      for (final CanvObjectModel obj in state)
        if (obj.id == id) updatedObj else obj,
    ];
  }

  /// get object position
  Offset getPositionFromId(String id) {
    return state.firstWhere((CanvObjectModel element) => element.id == id).position;
  }

  /// get object width
  double getWidthFromId(String id) {
    return state.firstWhere((CanvObjectModel element) => element.id == id).width;
  }

  /// get object height
  double getHeightFromId(String id) {
    return state.firstWhere((CanvObjectModel element) => element.id == id).height;
  }

  /// update object position
  void updatePosition({required String id, double? dx, double? dy}) {
    final CanvObjectModel tempObj =
        state.firstWhere((CanvObjectModel element) => element.id == id);

    late final CanvObjectModel updatedObj;

    if (dx != null && dy != null) {
      updatedObj = tempObj.copyWith(position: Offset(dx, dy));
    } else if (dx != null && dy == null) {
      updatedObj = tempObj.copyWith(position: Offset(dx, tempObj.position.dy));
    } else if (dx == null && dy != null) {
      updatedObj = tempObj.copyWith(position: Offset(tempObj.position.dx, dy));
    }

    /// update state by reassinging it
    state = [
      for (final CanvObjectModel obj in state)
        if (obj.id == id) updatedObj else obj,
    ];
  }

  /// update object width
  void updateWidth(double newWidth, String id) {
    final CanvObjectModel tempObj =
        state.firstWhere((CanvObjectModel element) => element.id == id);
    final CanvObjectModel updatedObj = tempObj.copyWith(width: newWidth);

    /// update state by reassinging it
    state = [
      for (final CanvObjectModel obj in state)
        if (obj.id == id) updatedObj else obj,
    ];
  }

  /// update object height
  void updateHeight(double newHeight, String id) {
    final CanvObjectModel tempObj =
        state.firstWhere((CanvObjectModel element) => element.id == id);
    final CanvObjectModel updatedObj = tempObj.copyWith(height: newHeight);

    /// update state by reassinging it
    state = [
      for (final CanvObjectModel obj in state)
        if (obj.id == id) updatedObj else obj,
    ];
  }

  /// update object size
  void updateSize(double newHeight, double newWidth, String id) {
    final CanvObjectModel tempObj =
        state.firstWhere((CanvObjectModel element) => element.id == id);
    final CanvObjectModel updatedObj =
        tempObj.copyWith(height: newHeight, width: newWidth);

    /// update state by reassinging it
    state = [
      for (final CanvObjectModel obj in state)
        if (obj.id == id) updatedObj else obj,
    ];
  }

  /// update object name
  void updateName(String newName, String id) {
    final CanvObjectModel tempObj =
        state.firstWhere((CanvObjectModel element) => element.id == id);
    final CanvObjectModel updatedObj = tempObj.copyWith(name: newName);

    /// update state by reassinging it
    state = [
      for (final CanvObjectModel obj in state)
        if (obj.id == id) updatedObj else obj,
    ];
  }

  /// update object background color
  void updateBackgroundColor(Color color, String id) {
    final CanvObjectModel tempObj =
        state.firstWhere((CanvObjectModel element) => element.id == id);
    final CanvObjectModel updatedObj = tempObj.copyWith(backgroundColor: color);

    /// update state by reassinging it
    state = [
      for (final CanvObjectModel obj in state)
        if (obj.id == id) updatedObj else obj,
    ];
  }

  /// update object border color
  void updateBorderColor(Color color, String id) {
    final CanvObjectModel tempObj =
        state.firstWhere((CanvObjectModel element) => element.id == id);
    final CanvObjectModel updatedObj = tempObj.copyWith(borderColor: color);

    /// update state by reassinging it
    state = [
      for (final CanvObjectModel obj in state)
        if (obj.id == id) updatedObj else obj,
    ];
  }

  /// update object name
  void updateCornerRadius(double radius, String id) {
    final CanvObjectModel tempObj =
        state.firstWhere((CanvObjectModel element) => element.id == id);
    final CanvObjectModel updatedObj = tempObj.copyWith(cornerRadius: radius);

    /// update state by reassinging it
    state = [
      for (final CanvObjectModel obj in state)
        if (obj.id == id) updatedObj else obj,
    ];
  }
}
