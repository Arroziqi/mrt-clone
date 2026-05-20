import 'dart:async';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../../config/theme/app_colors.dart';
import '../../../../config/theme/app_text_style.dart';
import '../../../../shared/models/mrt_station.dart';
import '../../data/repositories/payment_repository.dart';
import 'payment_success_page.dart';

class CheckoutWebviewPage extends StatefulWidget {
  final String invoiceUrl;
  final String orderId;
  final PaymentRepository paymentRepository;
  final MrtStation departure;
  final MrtStation destination;
  final int passengers;
  final double amount;

  const CheckoutWebviewPage({
    super.key,
    required this.invoiceUrl,
    required this.orderId,
    required this.paymentRepository,
    required this.departure,
    required this.destination,
    required this.passengers,
    required this.amount,
  });

  @override
  State<CheckoutWebviewPage> createState() => _CheckoutWebviewPageState();
}

class _CheckoutWebviewPageState extends State<CheckoutWebviewPage> {
  late final WebViewController _controller;
  Timer? _pollingTimer;
  bool _isCheckingStatus = false;
  bool _isLoadingWebView = true;

  @override
  void initState() {
    super.initState();
    
    // Initialize WebViewController
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Can be used to show standard loading indicator
          },
          onPageStarted: (String url) {
            setState(() {
              _isLoadingWebView = true;
            });
          },
          onPageFinished: (String url) {
            setState(() {
              _isLoadingWebView = false;
            });
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint("WebView resource error: ${error.description}");
          },
          onNavigationRequest: (NavigationRequest request) {
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.invoiceUrl));

    // Start transaction polling
    _startPolling();
  }

  void _startPolling() {
    _pollingTimer = Timer.periodic(const Duration(seconds: 3), (timer) async {
      if (_isCheckingStatus) return;

      setState(() {
        _isCheckingStatus = true;
      });

      try {
        final transaction = await widget.paymentRepository.getTransactionStatus(widget.orderId);
        debugPrint("Polled transaction status for ${widget.orderId}: ${transaction.status}");

        if (transaction.status == 'PAID') {
          _stopPolling();
          if (mounted) {
            // Navigate to PaymentSuccessPage and replace the current checkout route
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (_) => PaymentSuccessPage(
                  departure: widget.departure,
                  destination: widget.destination,
                  passengers: widget.passengers,
                  amount: widget.amount,
                  orderId: widget.orderId,
                ),
              ),
            );
          }
        } else if (transaction.status == 'FAILED' || transaction.status == 'EXPIRED') {
          _stopPolling();
          if (mounted) {
            Navigator.of(context).pop(); // Go back to BuyTicketPage
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Payment ${transaction.status.toLowerCase()}! Please try again.'),
                backgroundColor: Colors.red,
              ),
            );
          }
        }
      } catch (e) {
        // Log error and keep polling (intermittent network issues shouldn't abort)
        debugPrint("Error polling transaction status: $e");
      } finally {
        if (mounted) {
          setState(() {
            _isCheckingStatus = false;
          });
        }
      }
    });
  }

  void _stopPolling() {
    _pollingTimer?.cancel();
    _pollingTimer = null;
  }

  Future<bool> _onWillPop() async {
    final shouldClose = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cancel Payment?'),
        content: const Text('Are you sure you want to exit the checkout page? The transaction will remain pending until completed or expired.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('No, Continue'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Yes, Exit', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (shouldClose == true) {
      _stopPolling();
      return true;
    }
    return false;
  }

  @override
  void dispose() {
    _stopPolling();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        final shouldPop = await _onWillPop();
        if (shouldPop && context.mounted) {
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: AppColors.primaryBlue,
          foregroundColor: Colors.white,
          elevation: 0,
          title: Text(
            'Checkout MRT Ticket',
            style: AppTextStyle.title.copyWith(color: Colors.white, fontWeight: FontWeight.w700),
          ),
          centerTitle: false,
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () async {
              final shouldPop = await _onWillPop();
              if (shouldPop && context.mounted) {
                Navigator.of(context).pop();
              }
            },
          ),
          actions: [
            if (_isCheckingStatus)
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Center(
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
          ],
        ),
        body: Stack(
          children: [
            WebViewWidget(controller: _controller),
            if (_isLoadingWebView)
              const Center(
                child: CircularProgressIndicator(
                  color: AppColors.primaryBlue,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
