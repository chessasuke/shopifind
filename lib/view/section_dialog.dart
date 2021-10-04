import 'package:shopifind/controller/product_providers.dart';
import 'package:shopifind/model/canv_object_model.dart';
import 'package:shopifind/widgets/buttons.dart';
import 'package:shopifind/widgets/section_dialog_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SectionDialog extends StatelessWidget {
  const SectionDialog({Key? key, required this.obj}) : super(key: key);
  final CanvObjectModel obj;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Dialog(
      child: SizedBox(
        width: screenSize.width * 0.8,
        height: screenSize.height * 0.8,
        child: Column(
          children: [
            Container(
              constraints: const BoxConstraints(
                maxHeight: 50,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Container(
                      constraints: const BoxConstraints(maxWidth: 150),
                      child: Text(
                        obj.name,
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      DialogUploadBtn(sectionID: obj.id),
                      // DialogDeleteBtn(id: obj.id),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(8),
              width: screenSize.width * 0.6,
              height: 1,
              color: Theme.of(context).colorScheme.surface,
            ),
            Consumer(builder: (context, watch, child) {
              final products =
                  watch(productsBySectionProvider(obj.id)).state;
              if (products.isNotEmpty) {
                return SizedBox(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const DialogProductsHeading(),
                      SizedBox(
                        height: screenSize.height * 0.8 - 150,
                        child: ListView.builder(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            itemCount: products.length,
                            itemBuilder: (BuildContext context, int index) {
                              return DialogProductRecord(
                                index: index,
                                  color: index % 2 == 0
                                      ? Theme.of(context).colorScheme.secondary
                                      : Theme.of(context).colorScheme.primary,
                                  product: products.elementAt(index));
                            }),
                      ),
                    ],
                  ),
                );
              } else {
                return SizedBox(
                  height: screenSize.height * 0.5,
                  child: Align(
                    child: Text('Empty Section',
                        style: Theme.of(context).textTheme.headline2),
                  ),
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}
