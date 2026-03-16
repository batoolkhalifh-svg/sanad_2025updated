import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SadadPaymentPage extends StatelessWidget {
  final String paymentUrl;

  const SadadPaymentPage({super.key, required this.paymentUrl});

  Future<void> _openPayment(BuildContext context) async {
    final uri = Uri.parse(paymentUrl);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);

      // بعد فتح المتصفح، ارجع للتطبيق تلقائيًا
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("لا يمكن فتح صفحة الدفع")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Payment")),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _openPayment(context),
          child: const Text("اضغط هنا للدفع"),
        ),
      ),
    );
  }
}
