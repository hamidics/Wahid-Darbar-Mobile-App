/*
 
 */

import 'package:get_it/get_it.dart';
import 'package:wahiddarbar/core/common/navigation_service.dart';
import 'package:wahiddarbar/core/common/notification_service.dart';
import 'package:wahiddarbar/core/services/category_service.dart';
import 'package:wahiddarbar/core/services/controllers/category_service_controller.dart';
import 'package:wahiddarbar/core/services/controllers/customer_service_controller.dart';
import 'package:wahiddarbar/core/services/controllers/food_service_controller.dart';
import 'package:wahiddarbar/core/services/controllers/global_service_controller.dart';
import 'package:wahiddarbar/core/services/controllers/order_service_controller.dart';
import 'package:wahiddarbar/core/services/controllers/user_service_controller.dart';
import 'package:wahiddarbar/core/services/customer_service.dart';
import 'package:wahiddarbar/core/services/food_service.dart';
import 'package:wahiddarbar/core/services/global_service.dart';
import 'package:wahiddarbar/core/services/order_service.dart';
import 'package:wahiddarbar/core/services/user_service.dart';
import 'package:wahiddarbar/ui/pages/customer/main/customer_main_viewmodel.dart';
import 'package:wahiddarbar/ui/pages/food/home/food_home_viewmodel.dart';
import 'package:wahiddarbar/ui/pages/order/cart/cart_viewmodel.dart';

GetIt locator = GetIt.instance;

setupServices() {
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => NotificationService());

  //> Services
  locator.registerLazySingleton<GlobalService>(() => GlobalServiceController());

  locator.registerLazySingleton<UserService>(() => UserServiceController());

  locator.registerLazySingleton<FoodService>(() => FoodServiceController());

  locator.registerLazySingleton<CustomerService>(
      () => CustomerServiceController());

  locator.registerLazySingleton<OrderService>(() => OrderServiceController());

  locator.registerLazySingleton<CategoryService>(
      () => CategoryServiceController());

  // ViewModels
  locator.registerLazySingleton(() => FoodHomeViewModel());
  locator.registerLazySingleton(() => CustomerMainViewModel());
  locator.registerLazySingleton(() => CartViewModel());
}
