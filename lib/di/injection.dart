import 'package:dio/dio.dart';
import 'package:flutter_project/packages/core/analytics/analytics.dart';
import 'package:flutter_project/packages/core/event_bus/event_bus.dart';
import 'package:flutter_project/packages/core/logger/logger.dart';
import 'package:flutter_project/packages/core/network/network.dart';
import 'package:flutter_project/packages/features/products_list/data/repos/products_repo_impl.dart';
import 'package:flutter_project/packages/features/products_list/domain/repos/products_repo.dart';
import 'package:flutter_project/packages/features/products_list/presentation/blocs/products_bloc.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  getIt.registerLazySingleton<Logger>(() => ConsoleLogger()..initialize());
  getIt.registerLazySingleton<AnalyticsService>(() => ConsoleAnalytics());
  getIt.registerLazySingleton<EventBus>(() => EventBus());

  getIt.registerLazySingleton<Dio>(() => Dio());
  getIt.registerLazySingleton<ApiClient>(
    () => ApiClient(getIt<Dio>(), baseUrl: 'https://fakestoreapi.com'),
  );

  getIt.registerLazySingleton<IProductsRepo>(
    () => ProductsRepoImpl(apiClient: getIt()),
  );

  getIt.registerFactory<ProductsBloc>(
    () => ProductsBloc(productsRepo: getIt(), eventBus: getIt<EventBus>()),
  );
}
