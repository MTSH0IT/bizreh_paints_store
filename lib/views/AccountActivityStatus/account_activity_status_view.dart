import 'package:bizreh_paints_store/controllers/personal_controller.dart';
import 'package:bizreh_paints_store/views/payments/payments_view.dart';
import 'package:bizreh_paints_store/views/orderHistory/order_history.dart';
import 'package:bizreh_paints_store/views/eranedPoints/eraned_points_view.dart';
import 'package:bizreh_paints_store/utils/widgets/build_progress_indicator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:bizreh_paints_store/utils/widgets/common_app_bar.dart';
import 'package:bizreh_paints_store/utils/consts/colors.dart';
import 'package:get/get.dart' hide Trans;
import 'widgets/activity_status_card.dart';
import 'widgets/activity_section_header.dart';

class AccountActivityStatusView extends StatefulWidget {
  const AccountActivityStatusView({super.key});

  @override
  State<AccountActivityStatusView> createState() =>
      _AccountActivityStatusViewState();
}

class _AccountActivityStatusViewState extends State<AccountActivityStatusView> {
  final PersonalController ctrl = Get.find<PersonalController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ctrl.fetchUserReport();
    });
  }

  Widget _buildResponsiveRow({
    required Widget child1,
    required Widget child2,
    required bool isSmallScreen,
  }) {
    if (isSmallScreen) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [child1, const SizedBox(height: 8), child2],
      );
    } else {
      return Row(
        children: [
          Expanded(child: child1),
          const SizedBox(width: 8),
          Expanded(child: child2),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        titleKey: 'activity_status.title',
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isSmallScreen = constraints.maxWidth < 370;

                return Obx(() {
                  final isLoading = ctrl.isReportLoading.value;
                  final report = ctrl.userReport.value;

                  if (isLoading && report == null) {
                    return const BuildProgressIndicator();
                  }

                  final totalPayments =
                      report?.totalPayments?.toString() ?? '0';
                  final totalBonus = report?.totalBonus?.toString() ?? '0';
                  final totalRemaining =
                      report?.totalRemaining?.toString() ?? '0';
                  final paymentCount = report?.paymentCount?.toString() ?? '0';
                  final ordersTotal = report?.ordersTotal?.toString() ?? '0';
                  final ordersCount = report?.ordersCount?.toString() ?? '0';
                  final totalPointsBalance =
                      report?.totalPointsBalance?.toString() ?? '0';
                  final pointsEarned = report?.pointsEarned?.toString() ?? '0';
                  final pointsSpent = report?.pointsSpent?.toString() ?? '0';
                  final totalOperations =
                      report?.totalOperations?.toString() ?? '0';

                  return SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 12.0,
                    ),
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // --- PAYMENTS SECTION ---
                        ActivitySectionHeader(
                          title: tr('activity_status.payments_title'),
                          onTap: () {
                            Get.to(() => const PaymentsView());
                          },
                        ),
                        const SizedBox(height: 8),
                        _buildResponsiveRow(
                          isSmallScreen: isSmallScreen,
                          child1: ActivityStatusCard(
                            title: tr('activity_status.total_payments'),
                            value: totalPayments,
                            icon: Icons.credit_card_rounded,
                            iconColor: Colors.blue.shade700,
                            iconBgColor: Colors.blue.shade50,
                            valueColor: primaryColor,
                          ),
                          child2: ActivityStatusCard(
                            title: tr('activity_status.total_bonus'),
                            value: totalBonus,
                            icon: Icons.redeem_rounded,
                            iconColor: Colors.purple.shade700,
                            iconBgColor: Colors.purple.shade50,
                            valueColor: primaryColor,
                          ),
                        ),
                        const SizedBox(height: 12),
                        _buildResponsiveRow(
                          isSmallScreen: isSmallScreen,
                          child1: ActivityStatusCard(
                            title: tr('activity_status.remaining_amount'),
                            value: totalRemaining,
                            icon: Icons.account_balance_wallet_rounded,
                            iconColor: Colors.red.shade700,
                            iconBgColor: Colors.red.shade50,
                            valueColor: Colors.red.shade700,
                          ),
                          child2: ActivityStatusCard(
                            title: tr('activity_status.payments_count'),
                            value: paymentCount,
                            icon: Icons.receipt_rounded,
                            iconColor: Colors.blueGrey.shade600,
                            iconBgColor: Colors.blueGrey.shade50,
                            valueColor: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 24),

                        // --- ORDERS SECTION ---
                        ActivitySectionHeader(
                          title: tr('activity_status.orders_title'),
                          onTap: () {
                            Get.to(() => const OrderHistory());
                          },
                        ),
                        const SizedBox(height: 8),
                        _buildResponsiveRow(
                          isSmallScreen: isSmallScreen,
                          child1: ActivityStatusCard(
                            title: tr('activity_status.total_orders_price'),
                            value: ordersTotal,
                            icon: Icons.shopping_cart_rounded,
                            iconColor: Colors.blue.shade700,
                            iconBgColor: Colors.blue.shade50,
                            valueColor: Colors.black87,
                          ),
                          child2: ActivityStatusCard(
                            title: tr('activity_status.orders_count'),
                            value: ordersCount,
                            icon: Icons.inventory_rounded,
                            iconColor: Colors.blueGrey.shade600,
                            iconBgColor: Colors.blueGrey.shade50,
                            valueColor: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 24),

                        // --- POINTS SECTION ---
                        ActivitySectionHeader(
                          title: tr('activity_status.points_title'),
                          onTap: () {
                            Get.to(() => const EranedPointsView());
                          },
                        ),
                        const SizedBox(height: 8),
                        _buildResponsiveRow(
                          isSmallScreen: isSmallScreen,
                          child1: ActivityStatusCard(
                            title: tr('activity_status.points_balance'),
                            value: totalPointsBalance,
                            icon: Icons.star_rounded,
                            iconColor: Colors.indigo.shade700,
                            iconBgColor: Colors.indigo.shade50,
                            valueColor: Colors.indigo.shade700,
                          ),
                          child2: ActivityStatusCard(
                            title: tr('activity_status.earned_points'),
                            value: pointsEarned,
                            icon: Icons.add_circle_outline_rounded,
                            iconColor: Colors.blue.shade700,
                            iconBgColor: Colors.blue.shade50,
                            valueColor: Colors.indigo.shade700,
                          ),
                        ),
                        const SizedBox(height: 12),
                        _buildResponsiveRow(
                          isSmallScreen: isSmallScreen,
                          child1: ActivityStatusCard(
                            title: tr('activity_status.spent_points'),
                            value: pointsSpent,
                            icon: Icons.remove_circle_outline_rounded,
                            iconColor: Colors.orange.shade700,
                            iconBgColor: Colors.orange.shade50,
                            valueColor: Colors.orange.shade700,
                          ),
                          child2: ActivityStatusCard(
                            title: tr('activity_status.transactions_count'),
                            value: totalOperations,
                            icon: Icons.receipt_long_rounded,
                            iconColor: Colors.blueGrey.shade600,
                            iconBgColor: Colors.blueGrey.shade50,
                            valueColor: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  );
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
