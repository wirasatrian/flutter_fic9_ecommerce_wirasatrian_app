// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fic9_ecommerce_template_app/common/components/button.dart';
import 'package:fic9_ecommerce_template_app/common/components/row_text.dart';
import 'package:fic9_ecommerce_template_app/common/components/space_height.dart';
import 'package:fic9_ecommerce_template_app/common/constants/colors.dart';
import 'package:fic9_ecommerce_template_app/common/extensions/int_ext.dart';
import 'package:fic9_ecommerce_template_app/presentation/cart/bloc/cart/cart_bloc.dart';
import 'package:fic9_ecommerce_template_app/presentation/cart/widgets/cart_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartPage extends StatefulWidget {
  const CartPage({
    Key? key,
  }) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Keranjang'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // if (carts.isEmpty)
          //   Center(
          //     child: Padding(
          //       padding: EdgeInsets.only(
          //           top: MediaQuery.of(context).size.height * 0.2),
          //       child: Column(
          //         children: [
          //           const Text(
          //             'Oppsss..\nKeranjang Anda kosong nih!',
          //             style: TextStyle(fontSize: 18.0),
          //             textAlign: TextAlign.center,
          //           ),
          //           const SpaceHeight(20.0),
          //           Button.filled(
          //             width: 120.0,
          //             height: 40.0,
          //             onPressed: () {
          //               Navigator.popUntil(context, (route) => route.isFirst);
          //             },
          //             label: 'Cari yuk',
          //           ),
          //         ],
          //       ),
          //     ),
          //   ),
          BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
                loaded: (carts) {
                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    separatorBuilder: (context, index) =>
                        const SpaceHeight(16.0),
                    itemCount: carts.length,
                    itemBuilder: (context, index) {
                      return CartItemWidget(
                        data: carts[index],
                      );
                    },
                  );
                },
              );
            },
          ),

          // if (carts.isNotEmpty) const SpaceHeight(70.0),
          // if (carts.isNotEmpty)
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(5.0)),
              border: Border.all(color: ColorName.border),
            ),
            child: Column(
              children: [
                BlocBuilder<CartBloc, CartState>(
                  builder: (context, state) {
                    return state.maybeWhen(
                      orElse: () {
                        return RowText(
                            label: 'Total Harga', value: 0.currencyFormatRp);
                      },
                      loaded: (carts) {
                        int totalPrice = 0;
                        for (var cart in carts) {
                          totalPrice +=
                              cart.product.attributes.price * cart.quantity;
                        }
                        return RowText(
                          label: 'Total Harga',
                          value: totalPrice.currencyFormatRp,
                        );
                      },
                    );
                  },
                ),
                const SpaceHeight(12.0),
                RowText(
                  label: 'Biaya Pengiriman',
                  value: 150000.currencyFormatRp,
                ),
                const SpaceHeight(40.0),
                const Divider(color: ColorName.border),
                const SpaceHeight(12.0),
                RowText(
                  label: 'Total',
                  value: 190000.currencyFormatRp,
                  valueColor: ColorName.primary,
                  fontWeight: FontWeight.w700,
                ),
                const SpaceHeight(16.0),
                Button.filled(
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) => const PaymentPage(
                    //             url: '',
                    //           )),
                    // );
                  },
                  label: 'Bayar Sekarang',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
