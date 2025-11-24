import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bizreh_paints_store/utils/widgets/main_button.dart';
import 'package:bizreh_paints_store/controllers/personal_controller.dart';

import 'widgets/labeled_text_field.dart';

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
        title: const Text('Personal Info'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                Obx(
                  () => LabeledTextField(
                    label: 'First Name',
                    hint: 'Enter your first name',
                    controller: ctrl.firstNameCtrl,
                    errorText: ctrl.firstNameError.value,
                  ),
                ),
                Obx(
                  () => LabeledTextField(
                    label: 'Last Name',
                    hint: 'Enter your last name',
                    controller: ctrl.lastNameCtrl,
                    errorText: ctrl.lastNameError.value,
                  ),
                ),
                Obx(
                  () => LabeledTextField(
                    label: 'Email',
                    hint: 'Enter your email',
                    controller: ctrl.emailCtrl,
                    keyboardType: TextInputType.emailAddress,
                    errorText: ctrl.emailError.value,
                  ),
                ),
                Obx(
                  () => LabeledTextField(
                    label: 'Phone Number',
                    hint: 'Enter your phone number',
                    controller: ctrl.phoneCtrl,
                    keyboardType: TextInputType.phone,
                    errorText: ctrl.phoneError.value,
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: MainButton(
                    title: 'Save Changes',
                    onPressed: () => ctrl.changeInfo(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
