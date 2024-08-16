double convertToDouble(dynamic value) {
  if (value is int) {
    return value.toDouble();
  } else if (value is double) {
    return value;
  } else if (value is String) {
    // Try to parse the string to a double, return 0.0 if unsuccessful
    try {
      return double.parse(value);
    } catch (e) {
      return 0.0;
    }
  } else {
    return 0.0; // Default value for unsupported types
  }
}

int convertToInt(dynamic value) {
  if (value is int) {
    return value;
  } else if (value is double) {
    return value.toInt();
  } else if (value is String) {
    // Try to parse the string to an integer, return 0 if unsuccessful
    try {
      return int.parse(value);
    } catch (e) {
      return 0;
    }
  } else {
    return 0; // Default value for unsupported types
  }
}

String convertToKMB(String value) {
  double doubleValue = double.tryParse(value) ?? 0.0;

  // Check if the value is negative
  bool isNegative = doubleValue < 0;

  // Take the absolute value for processing
  doubleValue = doubleValue.abs();

  if (doubleValue < 1000) {
    // Less than 1000, no conversion needed
    return (isNegative ? '-' : '') + doubleValue.toStringAsFixed(2);
  } else if (doubleValue < 1000000) {
    // Between 1000 and 1 million, convert to K
    double kValue = doubleValue / 1000;
    return (isNegative ? '-' : '') + '${kValue.toStringAsFixed(2)}K';
  } else if (doubleValue < 1000000000) {
    // Between 1 million and 1 billion, convert to M
    double mValue = doubleValue / 1000000;
    return (isNegative ? '-' : '') + '${mValue.toStringAsFixed(2)}M';
  } else {
    // Above 1 billion, convert to B
    double bValue = doubleValue / 1000000000;
    return (isNegative ? '-' : '') + '${bValue.toStringAsFixed(2)}B';
  }
}
