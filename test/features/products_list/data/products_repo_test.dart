import 'package:flutter_project/packages/core/network/network.dart';
import 'package:flutter_project/packages/features/products_list/data/models/product_model.dart';
import 'package:flutter_project/packages/features/products_list/data/repos/products_repo_impl.dart';
import 'package:flutter_project/packages/features/products_list/domain/repos/products_repo.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import '../../../helpers/either_test_helpers.dart';

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
    test("productsRepo_fetchProducts_returnsListOfProducts", () async {
      when(() => mockApiClient.get(any<String>())).thenAnswer(
        (_) async => ApiResponse(
          data: mockResponse,
          statusCode: 200,
          message: "success",
        ),
      );

      final res = await productsRepo.getProductsList();

      expect(res.isRight(), true);
      final list = res.getRightOrThrow();
      expect(list, ProductModel.listFromJson(mockResponse));
    });

    test("productsRepo_fetchProducts_handlesApiException", () async {
      when(() => mockApiClient.get(any<String>())).thenAnswer(
        (_) => throw ApiException(
          message: "failed to get products",
          statusCode: 500,
        ),
      );

      final res = await productsRepo.getProductsList();

      expect(res.isLeft(), true);
      final failure = res.getLeftOrThrow();
      expect(failure.erroMessage, "failed to get products");
    });
  });
}
