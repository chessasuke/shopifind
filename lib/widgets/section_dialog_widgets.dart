import 'package:shopifind/controller/product_providers.dart';
import 'package:shopifind/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DialogProductsHeading extends StatelessWidget {
  const DialogProductsHeading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Row(
        children: [
          const SizedBox(
            width: 45,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Center(
                child: Text(
                  'ID',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          // Container(
          //   color: Colors.black,
          //   width: 1,
          //   height: 50,
          // ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Center(
                child: Text('Description',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontWeight: FontWeight.bold)),
              ),
            ),
          ),
          // Container(
          //   color: Colors.black,
          //   width: 1,
          //   height: 50,
          // ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Center(
                child: Text('Price',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontWeight: FontWeight.bold)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DialogProductRecord extends StatelessWidget {
  const DialogProductRecord(
      {Key? key, required this.index,  required this.color, required this.product})
      : super(key: key);

  final int index;
  final Color color;
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 50,
        color: color,
        child: Dismissible(
          background: Container(
              color: Colors.red,
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Icon(
                      FontAwesomeIcons.trash,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ))),
          key: UniqueKey(),
          onDismissed: (direction) {
            context.read(productsControllerProvider.notifier).remove(product.id);
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 45,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '${index+1}',
                    style: Theme.of(context).textTheme.bodyText1,
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
                    style: Theme.of(context).textTheme.bodyText1,
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
                  child: Text(product.description,
                      style: Theme.of(context).textTheme.bodyText1),
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
                  child: Text('${product.price}',
                      style: Theme.of(context).textTheme.bodyText1),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
