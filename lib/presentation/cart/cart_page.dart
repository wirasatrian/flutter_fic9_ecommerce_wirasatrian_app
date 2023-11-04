// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fic9_ecommerce_template_app/common/components/button.dart';
import 'package:fic9_ecommerce_template_app/common/components/row_text.dart';
import 'package:fic9_ecommerce_template_app/common/components/space_height.dart';
import 'package:fic9_ecommerce_template_app/common/constants/colors.dart';
import 'package:fic9_ecommerce_template_app/common/extensions/int_ext.dart';
import 'package:fic9_ecommerce_template_app/data/models/requests/order_request_model.dart';
import 'package:fic9_ecommerce_template_app/presentation/cart/bloc/cart/cart_bloc.dart';
import 'package:fic9_ecommerce_template_app/presentation/cart/bloc/order/order_bloc.dart';
import 'package:fic9_ecommerce_template_app/presentation/cart/widgets/cart_item_widget.dart';
import 'package:fic9_ecommerce_template_app/presentation/payment/payment_page.dart';
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

  List<Item> items = [];
  int total = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Keranjang'),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
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
            const SpaceHeight(70.0),
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
                          total = totalPrice;
                          items = carts
                              .map(
                                (e) => Item(
                                  id: e.product.id,
                                  productName: e.product.attributes.name,
                                  price: e.product.attributes.price,
                                  qty: e.quantity,
                                ),
                              )
                              .toList();
                          return Column(
                            children: [
                              RowText(
                                label: 'Total Harga',
                                value: totalPrice.currencyFormatRp,
                              ),
                              const SpaceHeight(12.0),
                              const RowText(
                                label: 'Biaya Pengiriman',
                                value: 'Gratis',
                              ),
                              const SpaceHeight(40.0),
                              const Divider(color: ColorName.border),
                              const SpaceHeight(12.0),
                              RowText(
                                label: 'Total',
                                value: totalPrice.currencyFormatRp,
                                valueColor: ColorName.primary,
                                fontWeight: FontWeight.w700,
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                  const SpaceHeight(16.0),
                  BlocConsumer<OrderBloc, OrderState>(
                    listener: (context, state) {
                      state.maybeWhen(
                        orElse: () {},
                        success: (response) {
                          // kosongkan Cart
                          context
                              .read<CartBloc>()
                              .add(const CartEvent.started());
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) {
                            return PaymentPage(
                              invoiceUrl: response.invoiceUrl,
                              orderId: response.externalId,
                            );
                          }));
                        },
                      );
                    },
                    builder: (context, state) {
                      return state.maybeWhen(
                        orElse: () {
                          return Button.filled(
                            onPressed: () {
                              context.read<OrderBloc>().add(
                                    OrderEvent.order(
                                      OrderRequestModel(
                                        data: Data(
                                          items: items,
                                          totalPrice: total,
                                          deliveryAddress: 'Singaraja',
                                          courierName: 'JNE',
                                          courierCost: 0,
                                          statusOrder: 'Waiting Payment',
                                        ),
                                      ),
                                    ),
                                  );
                            },
                            label: 'Bayar Sekarang',
                          );
                        },
                        loading: () {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
