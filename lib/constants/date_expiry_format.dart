class DateExpiryFormatter {
  final DateTime expiryDate;

  DateExpiryFormatter(this.expiryDate);

  String format() {
    
    if (expiryDate.difference(DateTime.now()).inDays < 0) {
      return 'Expired';
    } else if (expiryDate.difference(DateTime.now()).inDays == 0) {
      return 'Expires Today';
    } else if (expiryDate.difference(DateTime.now()).inDays == 1) {
      return 'Expires Tomorrow';
    } else if (expiryDate.difference(DateTime.now()).inDays >= 2 &&
        expiryDate.difference(DateTime.now()).inDays <= 15) {
      return 'Expires in ${expiryDate.difference(DateTime.now()).inDays} days';
    } else {
      return 'Expires on ${expiryDate.month}/${expiryDate.day}/${expiryDate.year}';
    }
  }
}
