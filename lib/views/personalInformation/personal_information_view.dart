import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bizreh_paints_store/utils/widgets/main_button.dart';
import 'package:bizreh_paints_store/controllers/personal_information_controller.dart';

import 'widgets/labeled_text_field.dart';

class PersonalInformation extends StatefulWidget {
  const PersonalInformation({super.key});

  @override
  State<PersonalInformation> createState() => _PersonalInformationState();
}

class _PersonalInformationState extends State<PersonalInformation> {
  final PersonalInformationController ctrl = Get.put(
    PersonalInformationController(),
  );

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              LabeledTextField(
                label: 'Name',
                hint: 'Enter your name',
                controller: ctrl.nameCtrl,
              ),
              LabeledTextField(
                label: 'Email',
                hint: 'Enter your email',
                controller: ctrl.emailCtrl,
                keyboardType: TextInputType.emailAddress,
              ),
              LabeledTextField(
                label: 'Phone Number',
                hint: 'Enter your phone number',
                controller: ctrl.phoneCtrl,
                keyboardType: TextInputType.phone,
              ),
              const Spacer(),
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
    );
  }
}
