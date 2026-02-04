/// Returns an error message when phone is invalid, or null when it is valid.
String? validatePhoneNumber(
  String? phone, {
  String? requiredMessage,
  String? invalidMessage,
}) {
  if (phone == null || phone.trim().isEmpty) {
    return requiredMessage ?? 'Phone is required';
  }
  final trimmed = phone.trim();

  final phoneRegex = RegExp(r'^(\+963\d{9}|09\d{8})$');
  if (!phoneRegex.hasMatch(trimmed)) {
    return invalidMessage ?? 'Enter a valid phone number';
  }
  return null;
}

/// Returns an error message when email is invalid, or null when it is valid.
String? validateEmailAddress(
  String? email, {
  String? requiredMessage,
  String? invalidMessage,
}) {
  if (email == null || email.trim().isEmpty) {
    return requiredMessage ?? 'Email is required';
  }

  final trimmed = email.trim();
  final emailRegex = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');
  if (!emailRegex.hasMatch(trimmed)) {
    return invalidMessage ?? 'Enter a valid email';
  }
  return null;
}

/// Returns an error message when password is invalid, or null when it is valid.
String? validatePasswordValue(
  String? password, {
  int minLength = 6,
  String? requiredMessage,
  String? tooShortMessage,
}) {
  if (password == null || password.isEmpty) {
    return requiredMessage ?? 'Password is required';
  }
  if (password.length < minLength) {
    return tooShortMessage ??
        'Password must be at least $minLength characters long';
  }
  return null;
}

/// Returns an error message when confirmation password doesn't match, or null when it is valid.
String? validateConfirmPassword(
  String? confirmPassword,
  String originalPassword, {
  String? requiredMessage,
  String? mismatchMessage,
}) {
  if (confirmPassword == null || confirmPassword.isEmpty) {
    return requiredMessage ?? 'Please confirm your password';
  }
  if (confirmPassword != originalPassword) {
    return mismatchMessage ?? 'Passwords do not match';
  }
  return null;
}
