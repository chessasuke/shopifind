import 'package:shopifind/controller/objects_providers.dart';
import 'package:shopifind/controller/product_providers.dart';
import 'package:shopifind/model/product_model.dart';
import 'package:shopifind/service/service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../utils.dart';

// class DialogDeleteBtn extends StatelessWidget {
//   const DialogDeleteBtn({Key? key, required this.id}) : super(key: key);

//   final String id;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       constraints: const BoxConstraints(
//         maxHeight: 50,
//       ),
//       child: GestureDetector(
//         onTap: () {
//           context.read(objProvider.notifier).removeObject(id);
//           Navigator.pop(context);
//         },
//         child: Padding(
//           padding: const EdgeInsets.all(4),
//           child: Container(
//             decoration: BoxDecoration(
//                 borderRadius: const BorderRadius.all(Radius.circular(10)),
//                 border: Border.all(
//                   color: Theme.of(context).colorScheme.onError,
//                 )),
//             child: Padding(
//               padding: const EdgeInsets.all(6.0),
//               child: Text('Delete',
//                   style: TextStyle(
//                       fontSize: 18,
//                       color: Theme.of(context).colorScheme.onError)),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

class DialogUploadBtn extends StatelessWidget {
  const DialogUploadBtn({Key? key, required this.sectionID}) : super(key: key);

  final String sectionID;

  Future<void> processContent(
      String rawContent, String currentSectionId, BuildContext context) async {
    final listRawProducts = Utils.splitContentByLines(rawContent);
    print('processed ${listRawProducts.length} products');
    int lineCount = 1;
    for (final item in listRawProducts) {
      final product = Utils.getProductFromLine(item, currentSectionId);
      if (product is ProductModel) {
        context.read(productsControllerProvider.notifier).add(product);
      } else if (product is String) {
        await showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: const Text('Error in Product Data'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text( 'Error in line $lineCount. \n' + product + '\nSkipping record'),
                      TextButton(onPressed: ()=>Navigator.pop(context), child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Theme.of(context).colorScheme.background),
                            borderRadius: const BorderRadius.all(Radius.circular(10))
                          ),
                          child: Text('Continue', style: TextStyle( fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onBackground),)),
                      ))
                    ],
                  ),
                ));
      }
      lineCount++;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          Container(
            constraints: const BoxConstraints(
              maxHeight: 50,
            ),
            child: GestureDetector(
              onTap: () async {
                final rawContent = await AppService.pickFileDesktop();
                if (rawContent != null) {
                  await processContent(rawContent, sectionID, context);
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      border: Border.all(
                        color: Theme.of(context).colorScheme.surface,
                      )),
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Text('Upload',
                        style: TextStyle(
                          fontSize: 18,
                          color: Theme.of(context).colorScheme.surface,
                        )),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
