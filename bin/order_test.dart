import 'dart:convert';
import 'dart:io';
import 'package:order_test/order.dart';

List<Order> orders = [];

void main() {
  print('🛒 Welcome to My Order System');
  loadInitialOrders();

  while (true) {
    print('\nChọn chức năng:');
    print('1. Xem tất cả đơn hàng');
    print('2. Thêm đơn hàng mới');
    print('3. Tìm kiếm theo tên sản phẩm');
    print('0. Thoát');
    stdout.write('Chọn: ');
    final choice = stdin.readLineSync();

    switch (choice) {
      case '1':
        showOrders();
        break;
      case '2':
        addOrder();
        break;
      case '3':
        searchOrder();
        break;
      case '0':
        print('👋 Tạm biệt!');
        exit(0);
      default:
        print('❌ Lựa chọn không hợp lệ.');
    }
  }
}

void loadInitialOrders() {
  const jsonString = '''
  [
    {"Item": "A1000", "ItemName": "Iphone 15", "Price": 1200, "Currency": "USD", "Quantity": 1},
    {"Item": "A1001", "ItemName": "Iphone 16", "Price": 1500, "Currency": "USD", "Quantity": 1}
  ]
  ''';

  final List<dynamic> jsonData = jsonDecode(jsonString);
  orders = jsonData.map((e) => Order.fromJson(e)).toList();
}

void showOrders() {
  if (orders.isEmpty) {
    print('📭 Không có đơn hàng nào.');
  } else {
    print('\n📦 Danh sách đơn hàng:');
    for (var order in orders) {
      print(order);
    }
  }
}

void addOrder() {
  stdout.write('Nhập mã sản phẩm (Item): ');
  String item = stdin.readLineSync()!;
  stdout.write('Nhập tên sản phẩm: ');
  String itemName = stdin.readLineSync()!;
  stdout.write('Nhập giá: ');
  int price = int.tryParse(stdin.readLineSync()!) ?? 0;
  stdout.write('Nhập đơn vị tiền tệ: ');
  String currency = stdin.readLineSync()!;
  stdout.write('Nhập số lượng: ');
  int quantity = int.tryParse(stdin.readLineSync()!) ?? 1;

  final order = Order(
    item: item,
    itemName: itemName,
    price: price,
    currency: currency,
    quantity: quantity,
  );

  orders.add(order);
  print('✅ Thêm đơn hàng thành công!');
}

void searchOrder() {
  stdout.write('🔍 Nhập tên sản phẩm để tìm: ');
  String keyword = stdin.readLineSync()!.toLowerCase();

  final result = orders.where((o) => o.itemName.toLowerCase().contains(keyword)).toList();

  if (result.isEmpty) {
    print('⚠️ Không tìm thấy đơn hàng nào.');
  } else {
    print('📋 Kết quả tìm kiếm:');
    for (var order in result) {
      print(order);
    }
  }
}
