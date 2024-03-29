import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopifind/common/constants/app_colors.dart';
import 'package:shopifind/screen_store_editor/controller/product_providers.dart';
import 'package:shopifind/screen_store_editor/model/product.dart';
import 'package:shopifind/screen_store_editor/utils/utils.dart';
import 'package:shopifind/service/analytics/events/actions_events.dart';
import 'package:shopifind/service/analytics/models/event.dart';
import 'package:shopifind/service/file_io_service.dart';
import 'package:flutter/material.dart';

class UploadProdcutsBtn extends ConsumerWidget {
  const UploadProdcutsBtn({Key? key, required this.sectionId})
      : super(key: key);

  final String sectionId;

  /// Process a google sheet file (comma separated)
  Future<void> processContent({
    required String rawContent,
    required String sectionId,
    required WidgetRef ref,
    required BuildContext context,
  }) async {
    final listRawProducts = Utils.splitContentByLines(rawContent);
    int lineCount = 1;
    for (final item in listRawProducts) {
      final product = Utils.getProductFromLine(item, sectionId);
      if (product is Product) {
        ref.read(productsControllerProvider.notifier).add(product);
      } else if (product is String) {
        await showDialog(
          context: context,
          builder: (context) => _ErrorAlert(
            lineCount: lineCount,
            productName: product,
          ),
        );
      }
      lineCount++;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          Container(
            constraints: const BoxConstraints(
              maxHeight: 50,
            ),
            child: TextButton(
                onPressed: () => _onPressed(context: context, ref: ref),
                child: const Text('Upload')),
          ),
        ],
      ),
    );
  }

  void _onPressed(
      {required BuildContext context, required WidgetRef ref}) async {
    Utils.trackEvent(
        event: Event(name: ActionsEvents.addProducts.name), ref: ref);

    final rawContent = await FileIoService.pickFileDesktop();
    if (rawContent != null) {
      await processContent(
        rawContent: rawContent,
        sectionId: sectionId,
        ref: ref,
        context: context,
      );
    }
  }
}

class _ErrorAlert extends StatelessWidget {
  const _ErrorAlert({
    required this.productName,
    required this.lineCount,
    Key? key,
  }) : super(key: key);

  final int lineCount;
  final String productName;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Error in Product Data'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Error in line $lineCount. \n$productName\nSkipping record'),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Continue',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.neutral400,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
