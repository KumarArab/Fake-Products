import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/di/injection.dart';
import 'package:flutter_project/packages/design/design_system/design_system.dart';
import 'package:flutter_project/packages/features/products_list/presentation/blocs/products_bloc.dart';
import 'package:flutter_project/packages/features/products_list/presentation/blocs/products_event.dart';
import 'package:flutter_project/packages/features/products_list/presentation/ui/products_list_screen.dart';

void main() {
  setupDependencies();
  runApp(const TamaraApp());
}

class TamaraApp extends StatelessWidget {
  const TamaraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tamara Products',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: AppColors.background,
        useMaterial3: true,
        appBarTheme: const AppBarTheme(centerTitle: true, elevation: 0),
      ),
      home: const ProductsPlaceholderScreen(),
    );
  }
}

class ProductsPlaceholderScreen extends StatelessWidget {
  const ProductsPlaceholderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ProductsBloc>()..add(FetchProductsEvent()),
      child: ProductsListingScreen(),
    );
  }
}
