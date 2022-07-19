import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shopifind/common/constants/app_colors.dart';
import 'package:shopifind/common/text/text_style.dart';
import 'package:shopifind/screen_store_editor/controller/product_providers.dart';
import 'package:shopifind/screen_store_editor/model/product.dart';

class DialogProductsHeading extends StatelessWidget {
  const DialogProductsHeading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Expanded(child: SizedBox()),
          Expanded(
            child: Text('ID', style: TextStyles.heading03),
          ),
          Expanded(
            child: Text('Description', style: TextStyles.heading03),
          ),
          Expanded(
            child: Text('Price', style: TextStyles.heading03),
          ),
        ],
      ),
    );
  }
}

class DialogProductRecord extends ConsumerWidget {
  const DialogProductRecord(
      {Key? key,
      required this.index,
      required this.color,
      required this.product})
      : super(key: key);

  final int index;
  final Color color;
  final Product product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Container(
        height: 50,
        color: color,
        child: Dismissible(
          background: Container(
            color: AppColors.error500,
            child: const Icon(
              FontAwesomeIcons.trash,
              color: AppColors.primary100,
            ),
          ),
          key: UniqueKey(),
          onDismissed: (direction) {
            ref.read(productsControllerProvider.notifier).remove(product.id);
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 45,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '${index + 1}',
                    style: TextStyles.body01,
                  ),
                ),
              ),
              Container(
                color: Colors.black,
                width: 1,
                height: 50,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    product.id,
                    style: TextStyles.body01,
                  ),
                ),
              ),
              Container(
                color: Colors.black,
                width: 1,
                height: 50,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    product.description,
                    style: TextStyles.body01,
                  ),
                ),
              ),
              Container(
                color: Colors.black,
                width: 1,
                height: 50,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '${product.price}',
                    style: TextStyles.body01,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
