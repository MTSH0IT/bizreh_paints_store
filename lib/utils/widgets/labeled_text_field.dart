import 'package:flutter/material.dart';

class LabeledTextField extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String? errorText;
  final bool obscureText;
  final int? maxLines;

  const LabeledTextField({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.errorText,
    this.obscureText = false,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 14, color: Colors.black87),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: controller,
            keyboardType: keyboardType,
            obscureText: obscureText,
            maxLines: maxLines,
            decoration: InputDecoration(
              hintText: hint,
              filled: true,
              fillColor: const Color(0xFFE9EFF6),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
              border: _buildOutlineInputBorder(),
              enabledBorder: _buildOutlineInputBorder(
                color: Colors.grey.withValues(alpha: 0.2),
              ),
              focusedBorder: _buildOutlineInputBorder(color: Colors.blue),
              errorBorder: _buildOutlineInputBorder(color: Colors.red),
              errorText: errorText,
            ),
          ),
        ],
      ),
    );
  }

  OutlineInputBorder _buildOutlineInputBorder({Color? color}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(
        color: color ?? Colors.grey.withValues(alpha: 0.2),
      ),
    );
  }
}
