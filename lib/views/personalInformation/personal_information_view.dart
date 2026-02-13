import 'package:bizreh_paints_store/utils/widgets/build_progress_indicator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:bizreh_paints_store/utils/widgets/main_button.dart';
import 'package:bizreh_paints_store/controllers/personal_controller.dart';

import '../../utils/widgets/labeled_text_field.dart';

class PersonalInformation extends StatefulWidget {
  const PersonalInformation({super.key});

  @override
  State<PersonalInformation> createState() => _PersonalInformationState();
}

class _PersonalInformationState extends State<PersonalInformation> {
  final PersonalController ctrl = Get.find<PersonalController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('personal_info.title'.tr()),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    Obx(
                      () => LabeledTextField(
                        label: 'personal_info.first_name'.tr(),
                        hint: 'personal_info.first_name_hint'.tr(),
                        controller: ctrl.firstNameCtrl,
                        errorText: ctrl.firstNameError.value,
                      ),
                    ),
                    Obx(
                      () => LabeledTextField(
                        label: 'personal_info.last_name'.tr(),
                        hint: 'personal_info.last_name_hint'.tr(),
                        controller: ctrl.lastNameCtrl,
                        errorText: ctrl.lastNameError.value,
                      ),
                    ),
                    // Obx(
                    //   () => LabeledTextField(
                    //     label: 'Email',
                    //     hint: 'Enter your email',
                    //     controller: ctrl.emailCtrl,
                    //     keyboardType: TextInputType.emailAddress,
                    //     errorText: ctrl.emailError.value,
                    //   ),
                    // ),
                    Obx(
                      () => LabeledTextField(
                        label: 'personal_info.phone'.tr(),
                        hint: 'personal_info.phone_hint'.tr(),
                        controller: ctrl.phoneCtrl,
                        keyboardType: TextInputType.phone,
                        errorText: ctrl.phoneError.value,
                      ),
                    ),
                    SizedBox(height: 24),
                    MainButton(
                      title: 'personal_info.save_changes'.tr(),
                      onPressed: () => ctrl.changeInfo(),
                    ),
                    SizedBox(height: 16),
                  ],
                ),
              ),
            ),
            Obx(
              () => ctrl.isLoding.value
                  ? Container(
                      color: Colors.black26,
                      child: const Center(child: BuildProgressIndicator()),
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}
