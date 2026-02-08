import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/packages/core/event_bus/event_bus.dart';
import 'package:flutter_project/packages/features/products_list/data/models/product_model.dart';
import 'package:flutter_project/packages/features/products_list/domain/repos/products_repo.dart';
import 'package:flutter_project/packages/features/products_list/presentation/blocs/products_bloc.dart';
import 'package:flutter_project/packages/features/products_list/presentation/blocs/products_event.dart';
import 'package:flutter_project/packages/features/products_list/presentation/ui/products_list_screen.dart';
import '../../../../../helpers/products_test_helpers.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

class MockIProductsRepo extends Mock implements IProductsRepo {}

class MockEventBus extends Mock implements EventBus {}

class TestKeys {
  static const productsLoadingIndicatorKey = Key("productsLoadingIndicatorKey");
  static const searchProductsLoadingIndicatorKey = Key("searchProductsLoadingIndicatorKey");
  static const productsGridKey = Key("productsGridKey");
  static const serachProductsGridKey = Key("serachProductsGridKey");
  static const noProductsFoundKey = Key("noProductsFoundKey");
  static const noSearchProductsFoundKey = Key("noSearchProductsFoundKey");
}

extension ProductsViewTestHelpers on WidgetTester {
  Finder get productsLoadingIndicatorKey => find.byKey(TestKeys.productsLoadingIndicatorKey);
  Finder get searchProductsLoadingIndicatorKey => find.byKey(TestKeys.searchProductsLoadingIndicatorKey);
  Finder get serachProductsGridKey => find.byKey(TestKeys.serachProductsGridKey);

  Finder get productsGridKey => find.byKey(TestKeys.productsGridKey);
  Finder get noProductsFoundKey => find.byKey(TestKeys.noProductsFoundKey);
  Finder get noSearchProductsFoundKey => find.byKey(TestKeys.noSearchProductsFoundKey);
}

void main() {
  late MockIProductsRepo mockIProductsRepo;
  late MockEventBus mockEventBus;

  setUp(() {
    mockIProductsRepo = MockIProductsRepo();
    mockEventBus = MockEventBus();
  });

  tearDown(() {
    mockEventBus.dispose();
  });
  group("Products Grid View Test Group", () {
    testWidgets("productsViewGrid_loadingStateTest_ciricularProgressIndicatorVisible", (tester) async {
      when(() => mockIProductsRepo.getProductsList()).thenAnswer(
        (invocation) => Future.delayed(Duration(seconds: 1), () {
          return right(ProductModel.listFromJson(mockProductsJson));
        }),
      );
      await tester.pumpWidget(
        MaterialApp(
          routes: {'/home': (_) => const SizedBox()},
          home: BlocProvider(
            create: (_) =>
                ProductsBloc(productsRepo: mockIProductsRepo, eventBus: mockEventBus)..add(FetchProductsEvent()),
            child: Scaffold(body: Column(children: [ProductsView()])),
          ),
        ),
      );
      await tester.pump();
      expect(tester.productsLoadingIndicatorKey, findsOne);
    });

    testWidgets("productsViewGrid_loadingStateTest_gridViewVisible", (tester) async {
      when(
        () => mockIProductsRepo.getProductsList(),
      ).thenAnswer((invocation) => Future.value(right(ProductModel.listFromJson(mockProductsJson))));
      await tester.pumpWidget(
        MaterialApp(
          routes: {'/home': (_) => const SizedBox()},
          home: BlocProvider(
            create: (_) =>
                ProductsBloc(productsRepo: mockIProductsRepo, eventBus: mockEventBus)..add(FetchProductsEvent()),
            child: Scaffold(body: Column(children: [ProductsView()])),
          ),
        ),
      );
      await tester.pump();
      expect(tester.productsGridKey, findsOne);
    });

    testWidgets("productsViewGrid_loadingStateTest_noProductsFoundVisible", (tester) async {
      when(() => mockIProductsRepo.getProductsList()).thenAnswer((invocation) => Future.value(right([])));
      await tester.pumpWidget(
        MaterialApp(
          routes: {'/home': (_) => const SizedBox()},
          home: BlocProvider(
            create: (_) =>
                ProductsBloc(productsRepo: mockIProductsRepo, eventBus: mockEventBus)..add(FetchProductsEvent()),
            child: Scaffold(body: Column(children: [ProductsView()])),
          ),
        ),
      );
      await tester.pump();
      expect(tester.noProductsFoundKey, findsOne);
    });
  });
}
