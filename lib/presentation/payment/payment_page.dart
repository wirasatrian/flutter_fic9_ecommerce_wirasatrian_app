// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:fic9_ecommerce_template_app/presentation/payment/bloc/order_detail/order_detail_bloc.dart';
import 'package:fic9_ecommerce_template_app/presentation/payment/widgets/failed_page.dart';
import 'package:fic9_ecommerce_template_app/presentation/payment/widgets/success_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({
    Key? key,
    required this.invoiceUrl,
    required this.orderId,
  }) : super(key: key);

  final String invoiceUrl;
  final String orderId;

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  WebViewController? _controller;
  Timer? _timer;

  @override
  void initState() {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.invoiceUrl));
    const oneSec = Duration(seconds: 5);
    _timer = Timer.periodic(oneSec, (Timer timer) {
      context
          .read<OrderDetailBloc>()
          .add(OrderDetailEvent.getOrderDetail(widget.orderId));
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //call check status every 5 seconds with timer

    return Scaffold(
      body: BlocListener<OrderDetailBloc, OrderDetailState>(
        listener: (context, state) {
          state.maybeWhen(
            orElse: () {},
            success: (order) {
              if (order.data.attributes.statusOrder == 'In-Process') {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (_) {
                  return const SuccessPage();
                }));
              } else if (order.data.attributes.statusOrder == 'Failed') {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (_) {
                  return const FailedPage();
                }));
              }
            },
          );
        },
        child: WebViewWidget(controller: _controller!),
      ),
    );
  }
}
