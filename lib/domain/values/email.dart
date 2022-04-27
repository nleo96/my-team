class EmailAddress {
  late final String user;

  late final String domain;

  late final String fullAddress;

  EmailAddress(String value)
      : assert(isValid(value), '$value is not a valid e-mail address.') {
    final List<String> parts = value.split("@");
    user = parts.first;
    domain = parts.last;
    fullAddress = value;
  }

  static bool isValid(source) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(source);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is EmailAddress && other.fullAddress == fullAddress;
  }

  @override
  int get hashCode => fullAddress.hashCode;

  @override
  String toString() => fullAddress;
}
