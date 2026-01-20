import 'package:bizreh_paints_store/utils/consts/colors.dart';
import 'package:bizreh_paints_store/utils/func/show_massage_snacbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bizreh_paints_store/controllers/order_controller.dart';
import 'package:bizreh_paints_store/controllers/address_controllers.dart';
import 'package:bizreh_paints_store/utils/func/get_user.dart';
import 'package:bizreh_paints_store/utils/widgets/main_button.dart';
import 'package:bizreh_paints_store/views/orderInit/widgets/phone_step.dart';
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
  final TextEditingController _phoneCtrl = TextEditingController();

  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _initPhone();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _phoneCtrl.dispose();
    orderController.selectedAddress.value = null;
    super.dispose();
  }

  Future<void> _initPhone() async {
    if (orderController.phoneNumber.value.isNotEmpty) {
      _phoneCtrl.text = orderController.phoneNumber.value;
      return;
    }
    try {
      final user = await getUser();
      if (user.phone.isNotEmpty) {
        orderController.setPhone(user.phone);
        _phoneCtrl.text = user.phone;
      }
    } catch (_) {}
  }

  void _next() {
    if (_currentPage == 0) {
      final v = _phoneCtrl.text.trim();
      if (v.isEmpty) {
        showMassage('Please enter your phone number', false);
        return;
      }
      orderController.setPhone(v);
      _goToPage(1);
    } else if (_currentPage == 1) {
      if (orderController.selectedAddress.value == null) {
        showMassage('Please select a delivery address', false);
        return;
      }
      _goToPage(2);
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
    if (_currentPage == 2) return 'Submit order';
    return 'Next';
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
        title: const Text(
          'Order setup',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                Status(name: "Phone", icon: null),
                Status(name: "Address", icon: null),
                Status(name: "Check", icon: null),
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
                      PhoneStep(phoneController: _phoneCtrl),
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
                      ? 'Submitting order...'
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
