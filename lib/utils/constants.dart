const String firebaseStorageProductImageDir = 'ProductImages';
const String currencySymbol = '৳';
const String serverKey = '';

abstract class OrderStatus{
  static const String pending = 'Pending';
  static const String processing = 'Processing';
  static const String delivered = 'Delivered';
  static const String cancelled = 'Cancelled';
  static const String returned = 'Returned';
}

abstract class NotificationType{
  static const String comment = 'New Comment';
  static const String order = 'New Order';
  static const String user = 'New User';
}