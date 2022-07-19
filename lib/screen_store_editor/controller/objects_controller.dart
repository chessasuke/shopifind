import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopifind/screen_store_editor/controller/store_controller.dart';
import 'package:shopifind/screen_store_editor/model/canv_obj.dart';
import 'package:shopifind/screen_store_editor/model/canvas_object_type.dart';

final objectsControllerProvider =
    StateNotifierProvider<CanvObjsNotifier, CanvasState>((ref) {
  final currentStore =
      ref.watch(storesControllerProvider.notifier).selectedStore;
  if (currentStore == null) {
    return CanvObjsNotifier(const CanvasState());
  } else {
    return CanvObjsNotifier(CanvasState(
      objects: currentStore.objects!,
      selectedObject: null,
    ));
  }
});

class CanvObjsNotifier extends StateNotifier<CanvasState> {
  CanvObjsNotifier([CanvasState? canvasState])
      : super(canvasState ?? const CanvasState());

  List<CanvObj> get objects => state.objects;
  CanvObj? get selectedObject => state.selectedObject;

  void selectObject(String id) {
    if (state.selectedObject?.id == id) {
      return;
    }

    late final CanvObj? selectedObject;
    for (final CanvObj obj in state.objects) {
      if (obj.id == id) {
        selectedObject = obj;
      }
    }
    state = state.copyWith(selectedObject: selectedObject);
  }

  void addObject(CanvObj newObj) {
    if (newObj.objType == ObjectType.store) {
      state = state.copyWith(
        objects: [newObj, ...state.objects],
        selectedObject: newObj,
      );
    } else {
      state = state.copyWith(
        objects: [...state.objects, newObj],
        selectedObject: newObj,
      );
    }
  }

  void removeObject(String id) {
    state = state.copyWith(
      objects: state.objects.where((CanvObj obj) => obj.id != id).toList(),
      selectedObject: null,
    );
  }

  void toggleLock(String id) {
    final List<CanvObj> newObjects = [];
    for (final CanvObj obj in state.objects) {
      if (id == obj.id) {
        newObjects.add(obj.copyWith(isLocked: !obj.isLocked));
      } else {
        newObjects.add(obj);
      }
    }
    state = state.copyWith(
      objects: newObjects,
      selectedObject: selectedObject,
    );
  }

  Position? getPosition(String id) {
    for (final CanvObj obj in state.objects) {
      if (obj.id == id) {
        return obj.position;
      }
    }
    return null;
  }

  Size? getSize(String id) {
    for (final CanvObj obj in state.objects) {
      if (obj.id == id) {
        return Size(obj.width, obj.height);
      }
    }
    return null;
  }

  void updateObj(CanvObj newObj) {
    // print('======== updateObj with position dx: ${newObj.position.dx}');
    final udpatedObjects = [
      for (final CanvObj obj in state.objects)
        if (obj.id == newObj.id) newObj else obj,
    ];
    // print(
    //     '===== BEFORE: ${state.objects.firstWhere((element) => element.id == newObj.id).position.dx}');
    state = state.copyWith(
      objects: udpatedObjects,
      selectedObject: newObj,
    );
    // print(
    //     '===== AFTER: ${state.objects.firstWhere((element) => element.id == newObj.id).position.dx}');
  }

  void clear() {
    state = const CanvasState();
  }
}

class CanvasState extends Equatable {
  const CanvasState({
    this.objects = const [],
    this.selectedObject,
  });

  final List<CanvObj> objects;
  final CanvObj? selectedObject;

  CanvasState copyWith({
    List<CanvObj>? objects,
    required CanvObj? selectedObject,
  }) {
    return CanvasState(
      objects: objects ?? this.objects,
      selectedObject: selectedObject,
    );
  }

  @override
  String toString() {
    return 'selectedObject id: ${selectedObject?.id} | type: ${selectedObject?.objType}';
  }

  @override
  List<Object?> get props => [objects, selectedObject];
}
