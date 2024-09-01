String formatPhoneNumber(String phone) {
  final originalPhone = phone;
  phone = phone.replaceAll(' ', ''); // Remove any existing spaces

  // Handle phone numbers starting with 0 and having 10 or 11 digits after the prefix
  if (phone.startsWith('0')) {
    if (phone.length == 11) {
      return '${phone.substring(1, 4)} ${phone.substring(4, 7)} ${phone.substring(7)}'; // 680 144 1344
    }
    if (phone.length == 12) {
      return '${phone.substring(1, 4)} ${phone.substring(4, 7)} ${phone.substring(7, 10)} ${phone.substring(10)}'; // 680 144 134 56
    }
  }

  // +43 and other country codes
  if (phone.startsWith('+')) {
    if (phone.startsWith('+43')) {
      if (phone.length == 13) {
        return '${phone.substring(3, 6)} ${phone.substring(6, 9)} ${phone.substring(9)}'; // 680 144 1344
      }
      if (phone.length == 14) {
        return '${phone.substring(3, 6)} ${phone.substring(6, 9)} ${phone.substring(9, 12)} ${phone.substring(12)}'; // 680 144 134 56
      }
    } else {
      if (phone.length == 13) {
        return '${phone.substring(0, 3)} ${phone.substring(3, 6)} ${phone.substring(6, 9)} ${phone.substring(9)}'; // +90 555 123 123 23
      }
      if (phone.length == 14) {
        return '${phone.substring(0, 3)} ${phone.substring(3, 6)} ${phone.substring(6, 9)} ${phone.substring(9)}'; // +90 555 123 123 23
      }
    }
  }

  // 10 digits
  if (phone.length == 10) {
    return '${phone.substring(0, 3)} ${phone.substring(3, 6)} ${phone.substring(6)}';
  }

  // 11 digits
  if (phone.length == 11) {
    return '${phone.substring(0, 3)} ${phone.substring(3, 6)} ${phone.substring(6, 9)} ${phone.substring(9)}'; // 555 123 123 23
  }

  // 12 digits
  if (phone.length == 12) {
    return '${phone.substring(0, 3)} ${phone.substring(3, 6)} ${phone.substring(6, 9)} ${phone.substring(9, 12)}'; // 555 123 123 23
  }

  // If none of the conditions match, return the original phone number
  return originalPhone;
}
