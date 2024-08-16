// ignore: prefer-match-file-name
abstract class PaymentProcessor {
  void processPayment();
}

abstract class InventoryManager {
  void updateInventory();
}

abstract class ShippingHandler {
  void shipOrder();
}

abstract class NotificationSender {
  void sendNotification();
}

class PaymentService implements PaymentProcessor {
  const PaymentService();

  @override
  void processPayment() {
    print('Processing payment...');
  }
}

class InventoryService implements InventoryManager {
  const InventoryService();

  @override
  void updateInventory() {
    print('Updating inventory...');
  }
}

class ShippingService implements ShippingHandler {
  const ShippingService();

  @override
  void shipOrder() {
    print('Shipping order...');
  }
}

class NotificationService implements NotificationSender {
  const NotificationService();

  @override
  void sendNotification() {
    print('Sending notification...');
  }
}

class OrderService {
  const OrderService({
    required this.paymentProcessor,
    required this.inventoryManager,
    required this.shippingHandler,
    required this.notificationSender,
  });

  final PaymentProcessor paymentProcessor;
  final InventoryManager inventoryManager;
  final ShippingHandler shippingHandler;
  final NotificationSender notificationSender;

  void processOrder() {
    paymentProcessor.processPayment();
    inventoryManager.updateInventory();
    shippingHandler.shipOrder();
    notificationSender.sendNotification();
  }
}

void main() {
  final orderService = OrderService(
    paymentProcessor: PaymentService(),
    inventoryManager: InventoryService(),
    shippingHandler: ShippingService(),
    notificationSender: NotificationService(),
  );
  orderService.processOrder();
}
