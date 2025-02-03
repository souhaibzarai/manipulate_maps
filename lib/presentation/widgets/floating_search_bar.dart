import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../../business_logic/cubit/places_cubit.dart';
import '../../constants/colors.dart';
import 'place_item.dart';

class FloatingSearchBar extends StatefulWidget {
  const FloatingSearchBar({super.key});

  @override
  State<FloatingSearchBar> createState() => _FloatingSearchBarState();
}

class _FloatingSearchBarState extends State<FloatingSearchBar> {
  final FocusNode _focusNode = FocusNode();
  final TextEditingController searchController = TextEditingController();

  List<dynamic> places = [];
  static const Uuid uuid = Uuid();
  bool isSearchOverlayVisible = false;

  @override
  void dispose() {
    searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void clearAndCloseSearch() {
    setState(() {
      searchController.clear();
      places.clear();
      isSearchOverlayVisible = false;
    });
    _focusNode.unfocus();
  }

  void fetchSuggestions(String query) {
    if (query.isNotEmpty) {
      BlocProvider.of<PlacesCubit>(context)
          .emitAllSuggestions(query, uuid.v4());
    }
  }

  Widget buildSearchBloc() {
    return BlocBuilder<PlacesCubit, PlacesState>(
      builder: (context, state) {
        if (state is PlacesLoaded) {
          places = state.places;
          return places.isNotEmpty ? buildPlacesList(places) : buildNoResults();
        } else if (state is PlacesError) {
          return buildErrorMessage(state.message);
        }
        return buildLoadingIndicator();
      },
    );
  }

  Widget buildPlacesList(List<dynamic> places) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemCount: places.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              searchController.text = places[index].name;
              isSearchOverlayVisible = false;
            });
            _focusNode.unfocus();
          },
          child: PlaceItem(suggestion: places[index]),
        );
      },
    );
  }

  Widget buildNoResults() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          searchController.text.isNotEmpty ? "No results found" : '',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  Widget buildErrorMessage(String message) {
    return Center(
      child: Text(
        "Error: $message",
        style: const TextStyle(color: AppColors.errorColor, fontSize: 16),
      ),
    );
  }

  Widget buildLoadingIndicator() {
    return const Center(child: CircularProgressIndicator());
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Stack(
      children: [
        Positioned(
          top: 20,
          left: 20,
          right: 20,
          child: Column(
            children: [
              Material(
                elevation: 4,
                borderRadius: BorderRadius.circular(12),
                color: AppColors.thirdColor.withAlpha(180),
                child: TextField(
                  controller: searchController,
                  focusNode: _focusNode,
                  onChanged: fetchSuggestions,
                  onTap: () => setState(() => isSearchOverlayVisible = true),
                  decoration: InputDecoration(
                    hintText: 'Search for a location...',
                    hintStyle: TextStyle(color: AppColors.darkColor),
                    prefixIcon:
                        const Icon(Icons.search, color: AppColors.darkColor),
                    suffixIcon: IconButton(
                      style: ButtonStyle(
                          iconColor:
                              WidgetStatePropertyAll(AppColors.darkColor)),
                      hoverColor: AppColors.transparentColor,
                      focusColor: AppColors.transparentColor,
                      onPressed: searchController.text.isNotEmpty ||
                              isSearchOverlayVisible
                          ? clearAndCloseSearch
                          : null,
                      icon: Icon(
                        searchController.text.isNotEmpty ||
                                isSearchOverlayVisible
                            ? Icons.clear
                            : null,
                      ),
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 14),
                  ),
                ),
              ),
              if (isSearchOverlayVisible)
                Container(
                  margin: const EdgeInsets.only(top: 8),
                  constraints: BoxConstraints(
                    maxHeight: size.height * 0.4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.transparentColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: SingleChildScrollView(
                    child: buildSearchBloc(),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
