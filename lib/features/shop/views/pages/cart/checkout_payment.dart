import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_bacsi_nguyentrongthuy/app/routers/routers_name.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:shop_bacsi_nguyentrongthuy/shared/widgets/app_bar.dart';

class CheckoutPaymentPage extends StatefulWidget {
  final String url;

  const CheckoutPaymentPage({
    super.key,
    required this.url,
  });

  @override
  State<CheckoutPaymentPage> createState() => _CheckoutPaymentPageState();
}

class _CheckoutPaymentPageState extends State<CheckoutPaymentPage> {
  late final WebViewController _controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (url) async {
            await _controller.runJavaScript('''
              document.querySelector('#header').style.display = 'none';
              document.querySelector('#footer').style.display = 'none';
              ''');
            Future.delayed(const Duration(seconds: 1), () async {
              await _controller.runJavaScript('''
              document.querySelector('#n8n-chat').style.display = 'none';
              document.querySelector('#salertWrapper').remove();
              ''');
            });

            final result = await _controller.runJavaScriptReturningResult('''
            (function() {
            const btn = document.querySelector('#input_casso');
            return btn && btn.innerText.trim() === 'BẠN ĐÃ THANH TOÁN THÀNH CÔNG';
            })()
            ''');
            if (result == true || result.toString() == 'true') {
              if (mounted) {
                context.go(RoutersName.orderPlaced);
              }
            }

            setState(() {
              _isLoading = false;
            });
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        showLeading: false,
      ),
      body: Stack(
        children: [
          WebViewWidget(
            controller: _controller,
          ),
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
