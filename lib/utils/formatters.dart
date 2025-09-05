import 'package:intl/intl.dart';

// Date Formatters
class DateFormatters {
  static final DateFormat _defaultDateFormat = DateFormat('yyyy-MM-dd');
  static final DateFormat _displayDateFormat = DateFormat('yyyy년 MM월 dd일');
  static final DateFormat _dateTimeFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
  static final DateFormat _displayDateTimeFormat = DateFormat('yyyy년 MM월 dd일 HH:mm');
  static final DateFormat _timeFormat = DateFormat('HH:mm');
  static final DateFormat _monthDayFormat = DateFormat('MM월 dd일');
  static final DateFormat _yearMonthFormat = DateFormat('yyyy년 MM월');

  /// Format date to default format (yyyy-MM-dd)
  static String formatDate(DateTime date) {
    return _defaultDateFormat.format(date);
  }

  /// Format date to display format (yyyy년 MM월 dd일)
  static String formatDisplayDate(DateTime date) {
    return _displayDateFormat.format(date);
  }

  /// Format datetime to default format (yyyy-MM-dd HH:mm:ss)
  static String formatDateTime(DateTime dateTime) {
    return _dateTimeFormat.format(dateTime);
  }

  /// Format datetime to display format (yyyy년 MM월 dd일 HH:mm)
  static String formatDisplayDateTime(DateTime dateTime) {
    return _displayDateTimeFormat.format(dateTime);
  }

  /// Format time to HH:mm format
  static String formatTime(DateTime dateTime) {
    return _timeFormat.format(dateTime);
  }

  /// Format date to month-day format (MM월 dd일)
  static String formatMonthDay(DateTime date) {
    return _monthDayFormat.format(date);
  }

  /// Format date to year-month format (yyyy년 MM월)
  static String formatYearMonth(DateTime date) {
    return _yearMonthFormat.format(date);
  }

  /// Parse date string to DateTime
  static DateTime? parseDate(String dateString) {
    try {
      return DateTime.parse(dateString);
    } catch (e) {
      return null;
    }
  }

  /// Get relative time string (e.g., "2일 전", "1시간 전")
  static String getRelativeTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 0) {
      return '${difference.inDays}일 전';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}시간 전';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}분 전';
    } else {
      return '방금 전';
    }
  }

  /// Check if date is today
  static bool isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year && date.month == now.month && date.day == now.day;
  }

  /// Check if date is yesterday
  static bool isYesterday(DateTime date) {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return date.year == yesterday.year && 
           date.month == yesterday.month && 
           date.day == yesterday.day;
  }
}

// Number Formatters
class NumberFormatters {
  static final NumberFormat _decimalFormat = NumberFormat('#,##0.##');
  static final NumberFormat _currencyFormat = NumberFormat('#,##0');
  static final NumberFormat _percentageFormat = NumberFormat('#0.#%');
  static final NumberFormat _weightFormat = NumberFormat('#,##0.###');

  /// Format number with commas (e.g., 1,234.56)
  static String formatNumber(num number) {
    return _decimalFormat.format(number);
  }

  /// Format currency (e.g., 1,234,567원)
  static String formatCurrency(num amount, {String currency = '원'}) {
    return '${_currencyFormat.format(amount)}$currency';
  }

  /// Format percentage (e.g., 12.5%)
  static String formatPercentage(double percentage) {
    return _percentageFormat.format(percentage / 100);
  }

  /// Format weight with kg unit (e.g., 1,234.567kg)
  static String formatWeight(double weight, {String unit = 'kg'}) {
    return '${_weightFormat.format(weight)}$unit';
  }

  /// Format file size (e.g., 1.5MB, 2.3GB)
  static String formatFileSize(int bytes) {
    if (bytes < 1024) {
      return '${bytes}B';
    } else if (bytes < 1024 * 1024) {
      return '${(bytes / 1024).toStringAsFixed(1)}KB';
    } else if (bytes < 1024 * 1024 * 1024) {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(1)}MB';
    } else {
      return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)}GB';
    }
  }

  /// Parse number from string with comma
  static double? parseNumber(String numberString) {
    try {
      return _decimalFormat.parse(numberString).toDouble();
    } catch (e) {
      return null;
    }
  }
}

// String Formatters
class StringFormatters {
  /// Capitalize first letter of each word
  static String toTitleCase(String text) {
    return text.split(' ')
        .map((word) => word.isEmpty 
            ? word 
            : word[0].toUpperCase() + word.substring(1).toLowerCase())
        .join(' ');
  }

  /// Truncate string with ellipsis
  static String truncate(String text, int maxLength, {String ellipsis = '...'}) {
    if (text.length <= maxLength) {
      return text;
    }
    return '${text.substring(0, maxLength - ellipsis.length)}$ellipsis';
  }

  /// Format phone number (010-1234-5678)
  static String formatPhoneNumber(String phoneNumber) {
    final cleaned = phoneNumber.replaceAll(RegExp(r'[^\d]'), '');
    if (cleaned.length == 11 && cleaned.startsWith('010')) {
      return '${cleaned.substring(0, 3)}-${cleaned.substring(3, 7)}-${cleaned.substring(7)}';
    } else if (cleaned.length == 10) {
      return '${cleaned.substring(0, 3)}-${cleaned.substring(3, 6)}-${cleaned.substring(6)}';
    }
    return phoneNumber;
  }

  /// Mask string (e.g., email: a***@example.com)
  static String maskString(String text, {int visibleStart = 1, int visibleEnd = 0, String maskChar = '*'}) {
    if (text.length <= visibleStart + visibleEnd) {
      return text;
    }
    
    final start = text.substring(0, visibleStart);
    final end = visibleEnd > 0 ? text.substring(text.length - visibleEnd) : '';
    final middle = maskChar * (text.length - visibleStart - visibleEnd);
    
    return start + middle + end;
  }

  /// Format coil number with dashes (ABC123456 -> ABC-123-456)
  static String formatCoilNumber(String coilNumber) {
    if (coilNumber.length >= 9) {
      return '${coilNumber.substring(0, 3)}-${coilNumber.substring(3, 6)}-${coilNumber.substring(6)}';
    }
    return coilNumber;
  }

  /// Remove all whitespace and special characters
  static String sanitize(String text) {
    return text.replaceAll(RegExp(r'[^\w\s]'), '').replaceAll(RegExp(r'\s+'), ' ').trim();
  }

  /// Check if string is empty or contains only whitespace
  static bool isNullOrEmpty(String? text) {
    return text == null || text.trim().isEmpty;
  }

  /// Generate initials from full name (김철수 -> 김철)
  static String getInitials(String fullName, {int maxLength = 2}) {
    final words = fullName.trim().split(' ');
    if (words.isEmpty) return '';
    
    if (words.length == 1) {
      return words[0].substring(0, maxLength.clamp(1, words[0].length));
    }
    
    return words
        .take(maxLength)
        .map((word) => word.isNotEmpty ? word[0] : '')
        .join('')
        .toUpperCase();
  }
}

// Validation Formatters
class ValidationFormatters {
  /// Validate email format
  static bool isValidEmail(String email) {
    return RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(email);
  }

  /// Validate Korean phone number
  static bool isValidPhoneNumber(String phoneNumber) {
    final cleaned = phoneNumber.replaceAll(RegExp(r'[^\d]'), '');
    return RegExp(r'^01[016789]\d{7,8}$').hasMatch(cleaned);
  }

  /// Validate coil number format
  static bool isValidCoilNumber(String coilNumber) {
    return RegExp(r'^[A-Z0-9]{8,12}$').hasMatch(coilNumber.toUpperCase());
  }

  /// Validate password strength
  static bool isStrongPassword(String password) {
    return password.length >= 8 &&
           RegExp(r'[A-Z]').hasMatch(password) &&
           RegExp(r'[a-z]').hasMatch(password) &&
           RegExp(r'\d').hasMatch(password) &&
           RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password);
  }

  /// Check if string contains only numbers
  static bool isNumeric(String text) {
    return RegExp(r'^\d+$').hasMatch(text);
  }

  /// Check if string contains only alphanumeric characters
  static bool isAlphanumeric(String text) {
    return RegExp(r'^[a-zA-Z0-9]+$').hasMatch(text);
  }
}
