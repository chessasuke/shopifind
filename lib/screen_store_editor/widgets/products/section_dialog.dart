import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopifind/common/constants/app_colors.dart';
import 'package:shopifind/common/text/text_style.dart';
import 'package:shopifind/screen_store_editor/controller/product_providers.dart';
import 'package:shopifind/screen_store_editor/model/canv_obj.dart';
import 'package:shopifind/screen_store_editor/widgets/products/dialog_products_heading.dart';
import 'package:shopifind/screen_store_editor/widgets/products/upload_products_btn.dart';

class ManageSectionDialog extends StatelessWidget {
  const ManageSectionDialog({
    required this.section,
    Key? key,
  }) : super(key: key);
  final CanvObj section;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 500),
        color: AppColors.neutral100,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _Heading(section: section),
              _MainContent(sectionId: section.id),
            ],
          ),
        ),
      ),
    );
  }
}

class _Heading extends StatelessWidget {
  const _Heading({
    required this.section,
    Key? key,
  }) : super(key: key);

  final CanvObj section;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AutoSizeText(
          section.description,
          style: TextStyles.heading02,
          maxLines: 1,
        ),
        const SizedBox(width: 16),
        UploadProdcutsBtn(sectionId: section.id),
      ],
    );
  }
}

class _MainContent extends StatelessWidget {
  const _MainContent({
    required this.sectionId,
    Key? key,
  }) : super(key: key);

  final String sectionId;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, WidgetRef ref, child) {
        final products = ref.watch(productsBySectionProvider(sectionId));
        if (products.isNotEmpty) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const DialogProductsHeading(),
              Container(
                constraints:
                    const BoxConstraints(maxHeight: 400, maxWidth: 500),
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemCount: products.length,
                  itemBuilder: (BuildContext context, int index) {
                    return DialogProductRecord(
                      index: index,
                      color: index % 2 == 0
                          ? AppColors.neutral200
                          : AppColors.neutral300,
                      product: products.elementAt(index),
                    );
                  },
                ),
              ),
            ],
          );
        } else {
          return Center(
            child: Text(
              'Empty Section',
              style: TextStyles.heading02,
            ),
          );
        }
      },
    );
  }
}
