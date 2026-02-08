import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/packages/design/design_system/tokens/app_typography.dart';
import 'package:flutter_project/packages/features/products_list/domain/entities/product.dart';
import 'package:flutter_project/packages/features/products_list/presentation/blocs/products_bloc.dart';
import 'package:flutter_project/packages/features/products_list/presentation/blocs/products_event.dart';
import 'package:flutter_project/packages/features/products_list/presentation/blocs/products_state.dart';

class ProductsListingScreen extends StatelessWidget {
  const ProductsListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[900],
        title: Text("Fake Products"),
      ),
      body: Column(children: [SearchBar(), ProductsView(), EmiSlider()]),
    );
  }
}

class EmiSlider extends StatefulWidget {
  const EmiSlider({super.key});

  @override
  State<EmiSlider> createState() => _EmiSliderState();
}

class _EmiSliderState extends State<EmiSlider> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 12),
          Text("Emi Slider", style: AppTypography.subtitle),

          BlocSelector<ProductsBloc, ProductsState, int>(
            selector: (state) => state.emiMonths,
            builder: (context, emiMonths) {
              final clamped = emiMonths.clamp(2, 12);
              return SafeArea(
                child: Slider.adaptive(
                  divisions: 10,
                  min: 0,
                  max: 1,
                  label: '$clamped months',
                  value: (clamped - 2) / 10,
                  onChanged: (val) {
                    final months = 2 + (val * 10).round();
                    context.read<ProductsBloc>().add(
                      UpdateEmiMonthsEvent(months: months.clamp(2, 12)),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class ProductsView extends StatelessWidget {
  const ProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<ProductsBloc, ProductsState>(
        builder: (ctx, state) {
          if (state.isloading)
            return Center(
              key: state.isSearchOn
                  ? const Key("searchProductsLoadingIndicatorKey")
                  : const Key("productsLoadingIndicatorKey"),
              child: CircularProgressIndicator.adaptive(),
            );
          if (state.isSearchOn) {
            if (state.searchProducts == null || state.searchProducts!.isEmpty) {
              return Center(
                key: const Key("noSearchProductsFoundKey"),
                child: Text("No Products Found, try again"),
              );
            }
            return ProductsGrid(
              key: const Key("searchProductsGridKey"),
              products: state.searchProducts!,
              emiMonths: state.emiMonths,
            );
          } else {
            if (!state.products.isEmpty) {
              return ProductsGrid(
                key: const Key("productsGridKey"),
                products: state.products,
                emiMonths: state.emiMonths,
              );
            }
            return Center(
              key: const Key("noProductsFoundKey"),
              child: Text("Wohh!! No Products Found"),
            );
          }
        },
      ),
    );
  }
}

class ProductsGrid extends StatelessWidget {
  const ProductsGrid({super.key, required this.products, this.emiMonths = 3});

  final List<Product> products;
  final int emiMonths;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.5,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: products.length,
      padding: EdgeInsets.all(16),
      itemBuilder: (context, i) {
        return Container(
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.blueGrey),
            borderRadius: BorderRadius.circular(16),
          ),
          padding: EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: CachedNetworkImage(
                  imageUrl: products[i].image!,
                  errorWidget: (context, url, error) => Text(error.toString()),
                ),
              ),
              SizedBox(height: 8),
              Text(
                products[i].title ?? "",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
              ),
              SizedBox(height: 4),
              Text(
                products[i].description ?? "",
                style: TextStyle(fontSize: 12),

                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 8),
              Text(
                "${products[i].monthlyEmi(emiMonths).toStringAsFixed(2)} SAR/mo",
                style: AppTypography.title.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: Colors.green[900],
                ),
              ),
              Text(
                "${products[i].price} SAR total",
                style: AppTypography.regular.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class SearchBar extends StatefulWidget {
  const SearchBar({super.key});

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  late TextEditingController searchFieldController;

  @override
  void initState() {
    searchFieldController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    searchFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green[900],
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: BlocSelector<ProductsBloc, ProductsState, bool>(
        selector: (state) => state.isSearchOn,
        builder: (context, isSearchOn) {
          if (isSearchOn)
            return Container(
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(width: 1, color: Colors.grey),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      autofocus: true,
                      controller: searchFieldController,
                      onChanged: (val) {
                        context.read<ProductsBloc>().add(
                          SearchProductsEvent(searchString: val),
                        );
                      },

                      decoration: InputDecoration(
                        hint: Text("Search products"),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      searchFieldController.clear();
                      context.read<ProductsBloc>().add(
                        ToggleProductsSearchEvent(),
                      );
                    },
                    icon: Icon(Icons.cancel),
                  ),
                ],
              ),
            );
          else
            return GestureDetector(
              onTap: () {
                context.read<ProductsBloc>().add(ToggleProductsSearchEvent());
              },
              child: Container(
                height: 50,
                width: double.maxFinite,
                padding: EdgeInsets.all(12),
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(width: 1, color: Colors.grey),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text("Search products..."),
              ),
            );
        },
      ),
    );
  }
}
