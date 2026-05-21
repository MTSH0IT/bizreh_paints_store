import 'package:bizreh_paints_store/controllers/payments_controller.dart';
import 'package:bizreh_paints_store/utils/widgets/build_progress_indicator.dart';
import 'package:bizreh_paints_store/utils/widgets/common_app_bar.dart';
import 'package:bizreh_paints_store/views/payments/widgets/payment_history_item.dart';
import 'package:bizreh_paints_store/views/payments/widgets/payments_summary_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;

class PaymentsView extends StatelessWidget {
  const PaymentsView({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<PaymentsController>();

    return Scaffold(
      appBar: const CommonAppBar(titleKey: 'payments.title'),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Obx(() {
              final isLoading = ctrl.isLoading.value;
              final data = ctrl.paymentsData.value;
              final payments = data?.payments ?? [];
              final summary = data?.summary;

              if (isLoading && data == null) {
                return const BuildProgressIndicator();
              }

              return Column(
                children: [
                  const SizedBox(height: 12),
                  PaymentsSummaryCard(
                    totalRegularPayments: summary?.totalRegularPayments ?? 0,
                    totalBonus: summary?.totalBonus ?? 0,
                    totalTransactions: summary?.totalTransactions ?? 0,
                  ),
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        tr('payments.history'),
                        style: const TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: payments.isEmpty
                        ? Center(
                            child: Text(
                              tr('payments.empty'),
                              style: const TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          )
                        : ListView.builder(
                            itemCount: payments.length,
                            itemBuilder: (context, index) {
                              return PaymentHistoryItem(item: payments[index]);
                            },
                          ),
                  ),
                  const SizedBox(height: 24),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
