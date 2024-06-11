String formatPhoneNumber(String phone) {
  String ogPhone = phone;
  phone = phone.replaceAll(' ', ''); // Remove any existing spaces

  if (phone.startsWith('+43') || phone.startsWith('0')) {
    if (phone.length == 12 || (phone.startsWith('0') && phone.length == 11)) {
      // 680 144 1344
      return '${phone.substring(4, 7)} ${phone.substring(7)}';
    } else if (phone.length == 13 || (phone.startsWith('0') && phone.length == 12)) {
      // 680 144 134 56
      return '${phone.substring(4, 7)} ${phone.substring(7, 10)} ${phone.substring(10)}';
    }
  }

  else if (!phone.startsWith('+') || phone.startsWith('0')){
    if (phone.length == 10) {
      // 555 123 1234
      return '${phone.substring(0, 3)} ${phone.substring(3, 6)} ${phone.substring(6)}';
    } else if (phone.length == 11) {
      // 555 123 123 23
      return '${phone.substring(0, 3)} ${phone.substring(3, 6)} ${phone.substring(6, 9)} ${phone.substring(9)}';
    }
  }

  else {
    if (phone.length == 13) {
      // +90 555 123 123 23
      return '${phone.substring(0, 3)} ${phone.substring(3, 6)} ${phone.substring(6,9)} ${phone.substring(9)}';
    } else if (phone.length == 14) {
      // +90 555 123 123 23
      return '${phone.substring(0, 3)} ${phone.substring(3, 6)} ${phone.substring(6, 9)} ${phone.substring(9)}';
    }
  }

  // If none of the conditions match, return the original phone number
  return ogPhone;
}


