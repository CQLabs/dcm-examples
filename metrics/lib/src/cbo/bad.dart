// ignore: prefer-match-file-name
class PaymentService {
  const PaymentService();

  void processPayment() {
    print('Processing payment...');
  }
}

class InventoryService {
  const InventoryService();

  void updateInventory() {
    print('Updating inventory...');
  }
}

class ShippingService {
  const ShippingService();

  void shipOrder() {
    print('Shipping order...');
  }
}

class NotificationService {
  const NotificationService();

  void sendNotification() {
    print('Sending notification...');
  }
}

class OrderService {
  final PaymentService paymentService = PaymentService();
  final InventoryService inventoryService = InventoryService();
  final ShippingService shippingService = ShippingService();
  final NotificationService notificationService = NotificationService();

  void processOrder() {
    paymentService.processPayment();
    inventoryService.updateInventory();
    shippingService.shipOrder();
    notificationService.sendNotification();
  }
}

void main() {
  final orderService = OrderService();
  orderService.processOrder();
}
