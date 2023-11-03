// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fic9_ecommerce_template_app/common/components/button.dart';
import 'package:fic9_ecommerce_template_app/common/components/space_height.dart';
import 'package:fic9_ecommerce_template_app/common/constants/colors.dart';
import 'package:fic9_ecommerce_template_app/common/constants/images.dart'
    as localImage;
import 'package:fic9_ecommerce_template_app/common/constants/variables.dart';
import 'package:fic9_ecommerce_template_app/data/models/responses/products_response_model.dart';
import 'package:fic9_ecommerce_template_app/presentation/cart/bloc/cart/cart_bloc.dart';
import 'package:fic9_ecommerce_template_app/presentation/cart/cart_page.dart';
import 'package:fic9_ecommerce_template_app/presentation/cart/widgets/cart_model.dart';
import 'package:fic9_ecommerce_template_app/presentation/home/widgets/image_slider.dart';
import 'package:fic9_ecommerce_template_app/presentation/product_detail/widgets/product_description_widget.dart';
import 'package:fic9_ecommerce_template_app/presentation/product_detail/widgets/product_info_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({
    Key? key,
    required this.product,
  }) : super(key: key);
  final Product product;

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  EdgeInsets paddingHorizontal = const EdgeInsets.symmetric(horizontal: 20.0);
  final List<String> images = [
    localImage.Images.product3,
    localImage.Images.product3,
    localImage.Images.product3,
    localImage.Images.product3,
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Produk"),
      ),
      body: ListView(
        children: [
          ImageSlider(
            items: [
              '${Variables.baseUrl}${widget.product.attributes.image.data.first.attributes.url}'
            ],
            isAsset: false,
          ),
          const SpaceHeight(16.0),
          ProductInfoWidget(
            padding: paddingHorizontal,
            product: widget.product,
            onWishlistTap: (isWishlist) {
              // TODO: on wishlist tap
            },
          ),
          const SpaceHeight(11.0),
          ProductDescriptionWidget(
            padding: paddingHorizontal,
            description: widget.product.attributes.description,
          ),
          const SpaceHeight(11.0),
          Padding(
            padding: paddingHorizontal,
            child: Divider(
              color: ColorName.grey.withOpacity(0.18),
            ),
          ),
          const SpaceHeight(11.0),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: Colors.grey.withOpacity(0.18)),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Button.filled(
                onPressed: () {
                  context.read<CartBloc>().add(
                        CartEvent.add(
                          CartModel(
                            product: widget.product,
                            quantity: 1,
                          ),
                        ),
                      );
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CartPage(),
                    ),
                  );
                },
                label: "Add to Cart",
              ),
            ),
            const SpaceWidth(15.0),
            Flexible(
              child: Button.outlined(
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //       builder: (context) => const PaymentPage()),
                  // );
                },
                label: "Buy Now",
                color: ColorName.light,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
