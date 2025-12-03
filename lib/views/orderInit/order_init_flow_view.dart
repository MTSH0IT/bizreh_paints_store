import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bizreh_paints_store/controllers/order_controller.dart';
import 'package:bizreh_paints_store/controllers/address_controllers.dart';
import 'package:bizreh_paints_store/models/address_model.dart';
import 'package:bizreh_paints_store/utils/consts/colors.dart';
import 'package:bizreh_paints_store/utils/func/get_user.dart';
import 'package:bizreh_paints_store/utils/widgets/main_button.dart';
import 'package:bizreh_paints_store/utils/widgets/build_progress_indicator.dart';
import 'package:bizreh_paints_store/views/savedAddress/widgets/address_card.dart';

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
        Get.snackbar('تنبيه', 'يرجى إدخال رقم الهاتف');
        return;
      }
      orderController.setPhone(v);
      _goToPage(1);
    } else if (_currentPage == 1) {
      if (orderController.selectedAddress.value == null) {
        Get.snackbar('تنبيه', 'يرجى اختيار عنوان التوصيل');
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
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  String get _buttonTitle {
    if (_currentPage == 2) return 'ارسال الطلب';
    return 'التالي';
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
          'تهيئة الطلب',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 8),
            _buildStepIndicator(),
            const SizedBox(height: 8),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Card(
                  elevation: 0,
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
                      _buildPhoneStep(),
                      _buildAddressStep(),
                      _buildConfirmStep(),
                    ],
                  ),
                ),
              ),
            ),
            Obx(() {
              return MainButton(
                title: orderController.isSubmitting.value
                    ? 'جاري ارسال الطلب...'
                    : _buttonTitle,
                onPressed: orderController.isSubmitting.value ? null : _next,
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildStepIndicator() {
    const titles = ['الهاتف', 'العنوان', 'التأكيد'];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: List.generate(3, (index) {
              final isActive = index == _currentPage;
              return Expanded(
                child: Row(
                  children: [
                    Container(
                      width: 26,
                      height: 26,
                      decoration: BoxDecoration(
                        color: isActive ? primaryColor : Colors.grey[300],
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '${index + 1}',
                        style: TextStyle(
                          color: isActive ? Colors.white : Colors.black87,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    if (index < 2)
                      Expanded(
                        child: Container(
                          height: 2,
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          color: index < _currentPage
                              ? primaryColor
                              : Colors.grey[300],
                        ),
                      ),
                  ],
                ),
              );
            }),
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(3, (index) {
              final isActive = index == _currentPage;
              return SizedBox(
                width: 80,
                child: Text(
                  titles[index],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: isActive ? primaryColor : Colors.black54,
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildPhoneStep() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          const Text(
            'ادخل رقم الهاتف للتواصل معك بخصوص الطلب',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _phoneCtrl,
            keyboardType: TextInputType.phone,
            decoration: const InputDecoration(
              labelText: 'رقم الهاتف',
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddressStep() {
    return Obx(() {
      if (addressController.isLoading.value) {
        return const BuildProgressIndicator();
      }
      final List<AddressModel> items = addressController.addresses;
      if (items.isEmpty) {
        return const Center(
          child: Text(
            'لا توجد عناوين محفوظة، قم بإضافة عنوان أولاً من صفحة العناوين',
          ),
        );
      }
      return ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final address = items[index];
          final isSelected =
              address.id == orderController.selectedAddress.value?.id;
          return GestureDetector(
            onTap: () {
              orderController.selectedAddress.value = address;
              setState(() {});
            },
            child: Opacity(
              opacity: isSelected ? 1.0 : 0.8,
              child: AddressCard(
                isDefaultAddress: isSelected,
                address: address,
                onEdit: null,
                onDelete: null,
              ),
            ),
          );
        },
      );
    });
  }

  Widget _buildConfirmStep() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Obx(() {
        final address = orderController.selectedAddress.value;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'تأكيد الطلب',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              'رقم الهاتف:',
              style: TextStyle(fontSize: 14, color: Colors.grey[700]),
            ),
            const SizedBox(height: 4),
            Text(
              orderController.phoneNumber.value,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),
            Text(
              'عنوان التوصيل:',
              style: TextStyle(fontSize: 14, color: Colors.grey[700]),
            ),
            const SizedBox(height: 4),
            if (address != null)
              Text(
                '${address.cityName ?? ''} - ${address.addressLine ?? ''}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              )
            else
              const Text('لم يتم اختيار عنوان'),
            const SizedBox(height: 24),
            Text(
              'عند الضغط على "ارسال الطلب" سيتم إرسال طلبك باستخدام البيانات أعلاه.',
              style: TextStyle(fontSize: 13, color: Colors.grey[700]),
            ),
          ],
        );
      }),
    );
  }
}
