import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_project/packages/core/event_bus/event_bus.dart';
import 'package:flutter_project/packages/features/products_list/data/models/product_model.dart';
import 'package:flutter_project/packages/features/products_list/domain/repos/products_repo.dart';
import 'package:flutter_project/packages/features/products_list/presentation/blocs/products_bloc.dart';
import 'package:flutter_project/packages/features/products_list/presentation/blocs/products_event.dart';
import 'package:flutter_project/packages/features/products_list/presentation/blocs/products_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/products_test_helpers.dart';

class MockIProductsRepo extends Mock implements IProductsRepo {}

class MockEventBus extends Mock implements EventBus {}

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
  group("Products Bloc Test", () {
    blocTest<ProductsBloc, ProductsState>(
      "productsBloc_fetchProductsRequested_receivesProductsList",
      build: () => ProductsBloc(productsRepo: mockIProductsRepo, eventBus: mockEventBus),
      setUp: () {
        when(
          () => mockIProductsRepo.getProductsList(),
        ).thenAnswer((_) async => right(ProductModel.listFromJson(mockProductsJson)));
      },
      act: (bloc) => bloc.add(FetchProductsEvent()),
      expect: () {
        final products = ProductModel.listFromJson(mockProductsJson);
        return [
          ProductsState.inital().copyWith(isloading: true),
          ProductsState.inital().copyWith(isloading: false, products: products, errorMessage: null),
        ];
      },
    );
  });
}
