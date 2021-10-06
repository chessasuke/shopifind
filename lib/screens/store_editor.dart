import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopifind/controller/store_providers.dart';
import 'package:shopifind/view/top_bar.dart';
import 'package:flutter/material.dart';

import '../view/side_bar.dart';
import '../view/custom_canva.dart';

class StoreEditor extends StatelessWidget {
  const StoreEditor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final storeId = watch(selectedStoreIdProvider).state;
    // final selectedStore = watch(selectedStoreProvider).state;

    // print('selected store id: $storeId');
    // if(selectedStore != null)
    // print('selected store id from itself: ${selectedStore.id}');
    // else     print('selected store is null');

    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        width: screenSize.width,
        height: screenSize.height,
        child: Row(
          children: [
            /// sidebar
            SizedBox(
                height: screenSize.height, width: 150, child: const Sidebar()),

            /// topbar and canvas
            Column(
              children: [
                SizedBox(
                  height: 50,
                  width: screenSize.width - 150,
                  child: const TopBar(),
                ),
                SizedBox(
                  height: screenSize.height - 50,
                  width: screenSize.width - 150,
                  child: const CustomCanvas(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
