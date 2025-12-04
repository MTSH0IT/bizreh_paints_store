import 'package:flutter/material.dart';

class PhoneStep extends StatelessWidget {
  final TextEditingController phoneController;

  const PhoneStep({super.key, required this.phoneController});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Enter your phone number to contact you about the order',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: phoneController,
            keyboardType: TextInputType.phone,
            decoration: const InputDecoration(
              labelText: 'Phone Number',
              border: OutlineInputBorder(),
              hintText: 'Enter your phone number',
            ),
          ),
        ],
      ),
    );
  }
}
