import 'package:bizreh_paints_store/utils/consts/colors.dart';
import 'package:bizreh_paints_store/utils/func/show_massage_snacbar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:bizreh_paints_store/controllers/order_controller.dart';
import 'package:bizreh_paints_store/controllers/address_controllers.dart';
import 'package:bizreh_paints_store/utils/widgets/main_button.dart';
import 'package:bizreh_paints_store/views/orderInit/widgets/address_step.dart';
import 'package:bizreh_paints_store/views/orderInit/widgets/confirm_step.dart';
import 'package:progress_tracker/progress_tracker.dart';

class OrderInitFlowView extends StatefulWidget {
  const OrderInitFlowView({super.key});

  @override
  State<OrderInitFlowView> createState() => _OrderInitFlowViewState();
}

class _OrderInitFlowViewState extends State<OrderInitFlowView> {
  final PageController _pageController = PageController();
  final OrderController orderController = Get.find<OrderController>();
  final AddressController addressController = Get.find<AddressController>();

  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    orderController.selectedAddress.value = null;
    super.dispose();
  }

  void _next() {
    if (_currentPage == 0) {
      if (orderController.selectedAddress.value == null) {
        showMassage('order_init.select_address'.tr(), false);
        return;
      }
      _goToPage(1);
    } else {
      orderController.submitOrder();
    }
  }

  void _back() {
    if (_currentPage > 0) {
      _goToPage(_currentPage - 1);
    } else {
      Get.back();
    }
  }

  void _goToPage(int index) {
    if (_currentPage == index) return;
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
    );
  }

  String get _buttonTitle {
    if (_currentPage == 1) return 'order_init.submit_order'.tr();
    return 'order_init.next'.tr();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: _back,
        ),
        title: Text(
          'order_init.title'.tr(),
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // const SizedBox(height: 8),
            // StepIndicator(currentPage: _currentPage),
            ProgressTracker(
              key: ValueKey(_currentPage),
              currentIndex: _currentPage,
              statusList: [
                Status(name: "order_init.address".tr(), icon: null),
                Status(name: "order_init.check".tr(), icon: null),
              ],
              activeColor: primaryColor,
              height: 80,
              showStepNumber: true,
              verticalPadding: 8,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Card(
                  color: Colors.white,
                  elevation: 2,

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: PageView(
                    controller: _pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    onPageChanged: (i) {
                      setState(() {
                        _currentPage = i;
                      });
                    },
                    children: [
                      AddressStep(
                        orderController: orderController,
                        addressController: addressController,
                        onAddressSelected: () {
                          setState(() {});
                        },
                      ),
                      ConfirmStep(orderController: orderController),
                    ],
                  ),
                ),
              ),
            ),
            Obx(() {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8,
                ),
                child: MainButton(
                  title: orderController.isSubmitting.value
                      ? 'order_init.submitting'.tr()
                      : _buttonTitle,
                  onPressed: orderController.isSubmitting.value ? null : _next,
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
