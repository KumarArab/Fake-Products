import 'package:flutter_project/packages/core/network/network.dart';
import 'package:flutter_project/packages/features/products_list/data/models/product_model.dart';
import 'package:flutter_project/packages/features/products_list/data/repos/products_repo_impl.dart';
import 'package:flutter_project/packages/features/products_list/domain/repos/products_repo.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import '../../../helpers/either_test_helpers.dart';
import '../../../helpers/products_test_helpers.dart';

class MockApiClient extends Mock implements ApiClient {}

void main() {
  late MockApiClient mockApiClient;
  late IProductsRepo productsRepo;
  setUp(() {
    mockApiClient = MockApiClient();
    productsRepo = ProductsRepoImpl(apiClient: mockApiClient);
  });
  setUpAll(() {});

  tearDown(() {});

  tearDownAll(() {});
  group("Products Repository Test", () {
    test("productsRepo_fetchProducts_returnsListOfProducts", () async {
      when(
        () => mockApiClient.get(any<String>()),
      ).thenAnswer((_) async => ApiResponse(data: mockProductsJson, statusCode: 200, message: "success"));

      final res = await productsRepo.getProductsList();

      expect(res.isRight(), true);
      final list = res.getRightOrThrow();
      expect(list, ProductModel.listFromJson(mockProductsJson));
    });

    test("productsRepo_fetchProducts_handlesApiException", () async {
      when(
        () => mockApiClient.get(any<String>()),
      ).thenAnswer((_) => throw ApiException(message: "failed to get products", statusCode: 500));

      final res = await productsRepo.getProductsList();

      expect(res.isLeft(), true);
      final failure = res.getLeftOrThrow();
      expect(failure.erroMessage, "failed to get products");
    });
  });
}
