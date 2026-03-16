import 'package:bizreh_paints_store/utils/widgets/build_progress_indicator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:bizreh_paints_store/utils/widgets/main_button.dart';
import 'package:bizreh_paints_store/controllers/personal_controller.dart';
import 'package:bizreh_paints_store/utils/widgets/common_app_bar.dart';

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
      appBar: const CommonAppBar(titleKey: 'personal_info.title'),
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
                        label: tr('personal_info.first_name'),
                        hint: tr('personal_info.first_name_hint'),
                        controller: ctrl.firstNameCtrl,
                        errorText: ctrl.firstNameError.value,
                      ),
                    ),
                    Obx(
                      () => LabeledTextField(
                        label: tr('personal_info.last_name'),
                        hint: tr('personal_info.last_name_hint'),
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
                        label: tr('personal_info.phone'),
                        hint: tr('personal_info.phone_hint'),
                        controller: ctrl.phoneCtrl,
                        keyboardType: TextInputType.phone,
                        errorText: ctrl.phoneError.value,
                      ),
                    ),
                    SizedBox(height: 24),
                    MainButton(
                      title: tr('personal_info.save_changes'),
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
