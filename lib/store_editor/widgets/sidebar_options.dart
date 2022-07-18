import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopifind/common/constants/app_colors.dart';
import 'package:shopifind/store_editor/controller/objects_controller.dart';
import 'package:shopifind/store_editor/model/canv_obj.dart';
import 'package:shopifind/store_editor/model/canvas_object_type.dart';
import 'package:shopifind/store_editor/widgets/object_editor/object_editor.dart';

class SidebarOptions extends ConsumerWidget {
  const SidebarOptions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
        print('rebuild sidebar options');

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const ObjectEditor(),
        const SizedBox(height: 16),
        GridView.count(
          shrinkWrap: true,
          crossAxisCount: 2,
          children: [
            for (final item in ObjectType.values)
              _SidebarTool(objectType: item),
          ],
        ),
      ],
    );
  }

// void _onTap() async {
//     bool? leave = false;
//     leave = await showDialog(
//         context: context,
//         builder: (context) {
//           return AlertDialog(
//             title: const Text('Are you sure you want to leave?'),
//             content: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 const Text('Any change not saved will be lost'),
//                 const SizedBox(height: 50),
//                 Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       TextButton(
//                         onPressed: () => Navigator.pop(context, true),
//                         child: Container(
//                           decoration: BoxDecoration(
//                               border: Border.all(
//                                   color: Theme.of(context)
//                                       .colorScheme
//                                       .onBackground),
//                               borderRadius:
//                                   const BorderRadius.all(Radius.circular(10))),
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Text('Leave',
//                                 style: Theme.of(context)
//                                     .primaryTextTheme
//                                     .bodyText1),
//                           ),
//                         ),
//                       ),
//                       TextButton(
//                         onPressed: () => Navigator.pop(context, false),
//                         child: Container(
//                           decoration: BoxDecoration(
//                               border: Border.all(
//                                   color: Theme.of(context)
//                                       .colorScheme
//                                       .onBackground),
//                               borderRadius:
//                                   const BorderRadius.all(Radius.circular(10))),
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Text('Return',
//                                 style: Theme.of(context)
//                                     .primaryTextTheme
//                                     .bodyText1),
//                           ),
//                         ),
//                       )
//                     ])
//               ],
//             ),
//           );
//         });

//     if (leave != null) {
//       if (leave) {
//         /// reset state of store editor
//         ref.read(productsControllerProvider.notifier).clear();
//         ref.read(objsControllerProvider.notifier).clear();
//         ref.read(selectedStoreIdProvider.notifier).state = '';
//         ref.read(selectedObjectProvider.notifier).state = null;
//         ref.read(selectedObjectIdProvider.notifier).state = '';
//         ref.read(selectedObjectProvider.notifier).state = null;
//         ref.refresh(storeFetcherProvider);
//         Navigator.pushAndRemoveUntil(
//             context,
//             MaterialPageRoute(builder: (context) => const LandingScreen()),
//             (route) => false);
//       }
//     }
//   }

}

class _SidebarTool extends ConsumerWidget {
  const _SidebarTool({
    required this.objectType,
    Key? key,
  }) : super(key: key);

  final ObjectType objectType;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print('rebuild sidebar Tool');

    return GestureDetector(
      onTap: () => _onTap(ref),
      child: Tooltip(
        message: objectType.getTooltipMsg(),
        child: Icon(
          objectType.getIcon(),
          color: AppColors.primary100,
        ),
      ),
    );
  }

  void _onTap(WidgetRef ref) {
    final newObj = CanvObj.initial(objectType);
    ref.read(objectsControllerProvider.notifier).addObject(newObj);
  }
}
