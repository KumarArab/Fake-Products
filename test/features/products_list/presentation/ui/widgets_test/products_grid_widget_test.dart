import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/packages/core/event_bus/event_bus.dart';
import 'package:flutter_project/packages/features/products_list/data/models/product_model.dart';
import 'package:flutter_project/packages/features/products_list/domain/repos/products_repo.dart';
import 'package:flutter_project/packages/features/products_list/presentation/blocs/products_bloc.dart';
import 'package:flutter_project/packages/features/products_list/presentation/blocs/products_event.dart';
import 'package:flutter_project/packages/features/products_list/presentation/blocs/products_state.dart';
import 'package:flutter_project/packages/features/products_list/presentation/ui/products_list_screen.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

class MockIProductsRepo extends Mock implements IProductsRepo {}

class MockEventBus extends Mock implements EventBus {}

class FakeProductsState extends Mock implements ProductsState {}

class FakeProductsEvent extends Mock implements ProductsEvent {}

class TestKeys {
  static const productsLoadingIndicatorKey = Key("productsLoadingIndicatorKey");
  static const searchLoadingIndicatorKey = Key("searchLoadingIndicatorKey");
  static const productsGridKey = Key("productsGridKey");
  static const serachProductsGridKey = Key("serachProductsGridKey");
  static const noProductsFoundKey = Key("noProductsFoundKey");
  static const noSearchProductsFoundKey = Key("noSearchProductsFoundKey");
}

extension ProductsViewTestHelpers on WidgetTester {
  Finder get productsLoadingIndicatorKey =>
      find.byKey(TestKeys.productsLoadingIndicatorKey);
  Finder get searchLoadingIndicatorKey =>
      find.byKey(TestKeys.searchLoadingIndicatorKey);
  Finder get serachProductsGridKey =>
      find.byKey(TestKeys.noSearchProductsFoundKey);

  Finder get productsGridKey => find.byKey(TestKeys.productsGridKey);
  Finder get noProductsFoundKey => find.byKey(TestKeys.noProductsFoundKey);
  Finder get noSearchProductsFoundKey =>
      find.byKey(TestKeys.noSearchProductsFoundKey);
}

void main() {
  late MockIProductsRepo mockIProductsRepo;
  late MockEventBus mockEventBus;

  setUp(() {
    mockIProductsRepo = MockIProductsRepo();
    mockEventBus = MockEventBus();

    registerFallbackValue(FakeProductsEvent());
    registerFallbackValue(FakeProductsState());
  });

  tearDown(() {
    mockEventBus.dispose();
  });
  group("Products Grid View Test Group", () {
    final mockResponse = [
      {
        "id": 1,
        "title": "Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops",
        "price": 109.95,
        "description":
            "Your perfect pack for everyday use and walks in the forest. Stash your laptop (up to 15 inches) in the padded sleeve, your everyday",
        "category": "men's clothing",
        "image": "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_t.png",
        "rating": {"rate": 3.9, "count": 120},
      },
      {
        "id": 2,
        "title": "Mens Casual Premium Slim Fit T-Shirts ",
        "price": 22.3,
        "description":
            "Slim-fitting style, contrast raglan long sleeve, three-button henley placket, light weight & soft fabric for breathable and comfortable wearing. And Solid stitched shirts with round neck made for durability and a great fit for casual fashion wear and diehard baseball fans. The Henley style round neckline includes a three-button placket.",
        "category": "men's clothing",
        "image":
            "https://fakestoreapi.com/img/71-3HjGNDUL._AC_SY879._SX._UX._SY._UY_t.png",
        "rating": {"rate": 4.1, "count": 259},
      },
    ];

    testWidgets(
      "productsViewGrid_loadingStateTest_ciricularProgressIndicatorVisible",
      (tester) async {
        when(() => mockIProductsRepo.getProductsList()).thenAnswer(
          (invocation) => Future.delayed(Duration(seconds: 1), () {
            return right(ProductModel.listFromJson(mockResponse));
          }),
        );
        await tester.pumpWidget(
          MaterialApp(
            routes: {'/home': (_) => const SizedBox()},
            home: BlocProvider(
              create: (_) => ProductsBloc(
                productsRepo: mockIProductsRepo,
                eventBus: mockEventBus,
              )..add(FetchProductsEvent()),
              child: Scaffold(body: ProductsView()),
            ),
          ),
        );
        tester.pumpAndSettle();
        expect(tester.productsLoadingIndicatorKey, findsOne);
        tester.pumpAndSettle(Duration(seconds: 2));
        expect(tester.productsGridKey, findsOne);
      },
    );
  });
}
